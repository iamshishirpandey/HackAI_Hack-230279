# 🌡️ Temperature Alert Agent

## 📜 Introduction

The Temperature Alert Agent is a state-of-the-art solution designed to keep users informed about temperature fluctuations in their chosen location. By harnessing the power of a free weather API, this agent provides real-time temperature updates and promptly notifies users when the temperature breaches their specified range.

## 🖥️ Backend

### 🛠️ Prerequisites

Python: Version 3.x or newer.
Flask: For creating the web server.
Firebase Admin SDK: To send push notifications.
Requests: To make API calls.

## 🚀 Setup

Repository Setup: Start by cloning the repository to your local machine.
Dependency Installation: Install all the necessary packages using:
bash
Copy code
pip install flask firebase-admin requests uagents
Firebase Configuration: Download your Firebase Admin SDK JSON file and place it in the root directory. For this demonstration, the file should be named techfest-df7f5-firebase-adminsdk-ekhyr-a58bac353f.json. ⚠️ This JSON file is strictly for testing purposes.

## 🏃 Execution

To get the backend up and running, execute the Flask app with:

python agent.py

## 📱 Frontend (Flutter Application)

The frontend, crafted with Flutter, offers a seamless user experience. It not only allows users to set their temperature preferences but also displays the current temperature. Integrated with Firebase Cloud Messaging, it ensures users receive timely temperature alerts.

## 🛠️ Prerequisites

Flutter SDK: To build and run the Flutter app.
Firebase Messaging Plugin: For push notifications.

## 🌟 Features

### 📅 Date Display: Always know the current date.

### 🌡️ Temperature View: See the current temperature for your chosen location at a glance.

### ⚙️ Custom Preferences: Set your temperature preferences, including latitude, longitude, and temperature range.

### 🔔 Real-time Alerts: Receive push notifications when the temperature deviates from your set range.

## 🖼️ Screenshots

Visual insights of the application can be found in the frontend directory.

## 🏃 Execution

Project Navigation: Move to the Flutter project directory.
App Launch: Run the Flutter app using:

flutter run

## 🎉 Conclusion

The Temperature Alert Agent is a holistic solution, bridging the backend and frontend, to ensure users are always in the know about temperature changes in their selected location. By synergizing the capabilities of Fetch.ai’s uAgents library, Flask, Firebase, and Flutter, it offers users the convenience to set preferences and the assurance of real-time alerts right on their devices. Stay informed, stay prepared! 🌞❄️

## Screenshots

![Alt text](https://github.com/iamshishirpandey/HackAI_Hack-230279/blob/main/frontend/temperature_alert_agent/screenshots/screenshot2.jpg)
![Alt text](https://github.com/iamshishirpandey/HackAI_Hack-230279/blob/main/frontend/temperature_alert_agent/screenshots/screenshot1.jpg)
![Alt text](https://github.com/iamshishirpandey/HackAI_Hack-230279/blob/main/frontend/temperature_alert_agent/screenshots/screenshot3.jpg)
