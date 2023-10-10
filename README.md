Temperature Alert Agent README
Introduction
The Temperature Alert Agent is designed to notify users when the temperature in their chosen location goes beyond their set range. This agent fetches real-time temperatures from a free weather API and sends an alert/notification to the user when the temperature goes below the minimum or above the maximum threshold they've set.

Backend
Prerequisites
Python 3.x
Flask
Firebase Admin SDK
Requests library
Setup
Clone the repository.
Install the required packages:
pip install flask firebase-admin requests uagents
Download your Firebase Admin SDK JSON file and place it in the root directory. For this example, the file is named techfest-df7f5-firebase-adminsdk-ekhyr-a58bac353f.json. Remember, this JSON file is for test purposes only.
Execution:
Run the Flask app:

python agent.py
Frontend (Flutter Application)
The frontend is a Flutter application that allows users to set their temperature preferences and view the current temperature. The application also integrates with Firebase Cloud Messaging to receive temperature alerts.

Prerequisites
Flutter SDK
Firebase Messaging Plugin
Features
Displays the current date.
Shows the current temperature for the user's chosen location.
Allows users to set their temperature preferences (latitude, longitude, min temperature, max temperature) and sends these preferences to the backend.
Receives push notifications when the temperature goes out of the set range.
Screenshots
Screenshots of the application can be found in the frontend directory.

Execution:
Navigate to the Flutter project directory.
Run the Flutter app:
bash
Copy code
flutter run
Conclusion
The Temperature Alert Agent, with its backend and frontend components, provides a comprehensive solution for users to stay informed about temperature changes in their chosen location. By leveraging the power of Fetch.ai’s uAgents library, Flask, Firebase, and Flutter, users can set their preferences and receive real-time alerts directly on their devices.
