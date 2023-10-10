import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart'; // For date formatting

void main() => runApp(MaterialApp(home: Homepage()));

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _minTempController = TextEditingController();
  final TextEditingController _maxTempController = TextEditingController();

  double? _currentTemperature;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 10), (timer) => _fetchTemperature());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _setPreferences() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.71:5000/set_preferences'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'latitude': _latitudeController.text,
        'longitude': _longitudeController.text,
        'min_temp': int.parse(_minTempController.text),
        'max_temp': int.parse(_maxTempController.text),
      }),
    );

    if (response.statusCode == 200) {
      print('Preferences set successfully!');
    } else {
      print('Failed to set preferences.');
    }
  }

  Future<void> _fetchTemperature() async {
    final response = await http.get(Uri.parse('http://192.168.1.71:5000/get_temperature'));

    if (response.statusCode == 200) {
      setState(() {
        _currentTemperature = jsonDecode(response.body)['temperature'];
      });
    } else {
      print('Failed to fetch temperature.');
    }
  }

  Future<void> _showPreferencesDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Preferences'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _latitudeController,
                  decoration: InputDecoration(labelText: 'Latitude'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _longitudeController,
                  decoration: InputDecoration(labelText: 'Longitude'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _minTempController,
                  decoration: InputDecoration(labelText: 'Min Temperature'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _maxTempController,
                  decoration: InputDecoration(labelText: 'Max Temperature'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Set'),
              onPressed: () {
                _setPreferences();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('EEEE, d MMMM y').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(title: Text('Temperature App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Colors.blueAccent),
              ),
              child: Text(
                formattedDate,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Text(
                  '${_currentTemperature ?? 'Fetching...'}°C',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showPreferencesDialog,
        tooltip: 'Set Preferences',
        child: Icon(Icons.settings),
      ),
    );
  }
}
