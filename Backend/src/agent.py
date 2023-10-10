from uagents import Agent, Context
from flask import Flask, request, jsonify
import json
import requests
from datetime import datetime

URL = "https://api.open-meteo.com/v1/forecast?"

def get_data(ctx, latitude, longitude) -> dict or None:

    url = (
        URL
        + f"latitude={latitude}&longitude={longitude}"
        + "&hourly=temperature_2m&forecast_days=1"
    )
    current_date = datetime.utcnow().date().isoformat()

    if ctx:  # Check if ctx is not None
        cached_data = ctx.storage.get("last_request")
        if cached_data:
            data = json.loads(cached_data)
            if data["date"] == current_date and data["url"] == url:
                return data["response"]

    response = requests.get(url=url, timeout=5)
    if response.status_code == 200:
        data = response.json()
        if ctx:  # Check if ctx is not None
            ctx.storage.set("last_request",
                json.dumps({"date": current_date, "url": url, "response": data})
            )
        return data
    return None

agent = Agent()
STORAGE = {
    "latitude": "52.198073",
    "longitude": "0.128294",
    "min_temp": 10,
    "max_temp": 25
}
@agent.on_interval(10)
async def query_data(ctx: Context):
    # Get user's preferred location and temperature range
    latitude = STORAGE.get("latitude", "52.198073")
    longitude = STORAGE.get("longitude", "0.128294")
    min_temp = STORAGE.get("min_temp", 0)
    max_temp = STORAGE.get("max_temp", 30)
    
    data = get_data(ctx, latitude, longitude)
    time = datetime.utcnow().hour
    current_temp = data['hourly']['temperature_2m'][time]

    ctx.logger.info(f"Your local temperature at {time} is {current_temp}°C.")
    
    if current_temp < min_temp or current_temp > max_temp:
        ctx.logger.warning(f"Alert! Temperature is out of your preferred range!")

def set_preferences(latitude, longitude, min_temp, max_temp):
    STORAGE["latitude"] = latitude
    STORAGE["longitude"] = longitude
    STORAGE["min_temp"] = min_temp
    STORAGE["max_temp"] = max_temp

app = Flask(__name__)

@app.route('/set_preferences', methods=['POST'])
def set_preferences_endpoint():
    data = request.json
    latitude = data.get('latitude')
    longitude = data.get('longitude')
    min_temp = data.get('min_temp', 10)
    max_temp = data.get('max_temp', 25)
    
    STORAGE["latitude"] = latitude
    STORAGE["longitude"] = longitude
    STORAGE["min_temp"] = min_temp
    STORAGE["max_temp"] = max_temp

    return jsonify({"message": "Preferences set successfully!"})

@app.route('/get_temperature', methods=['GET'])
def get_temperature_endpoint():
    latitude = STORAGE.get("latitude")
    longitude = STORAGE.get("longitude")
    
    data = get_data(None, latitude, longitude)
    time = datetime.utcnow().hour
    current_temp = data['hourly']['temperature_2m'][time]

    return jsonify({"temperature": current_temp})
if __name__ == "__main__":
    app.run(host='0.0.0.0',debug=True)

