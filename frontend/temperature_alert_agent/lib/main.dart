import 'package:flutter/material.dart';
import 'package:temperature_alert_agent/screens/homescreen.dart';

void main() => runApp(TemperatureAlertApp());

class TemperatureAlertApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Alert Agent',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Homepage(),
    );
  }
}
