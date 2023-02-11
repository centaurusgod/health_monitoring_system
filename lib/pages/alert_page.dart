import 'package:flutter/material.dart';

class HealthDataDisplay extends StatefulWidget {
  @override
  _HealthDataDisplayState createState() => _HealthDataDisplayState();
}

class _HealthDataDisplayState extends State<HealthDataDisplay> {
  List<Map<String, dynamic>> _data = [
    {
      'dateTime': DateTime.now().subtract(Duration(days: 2)),
      'maxHeartRate': 80,
      'minHeartRate': 72,
      'maxTemperature': 98.6,
      'minTemperature': 97.5
    },
    {
      'dateTime': DateTime.now().subtract(Duration(days: 1)),
      'maxHeartRate': 82,
      'minHeartRate': 74,
      'maxTemperature': 99.1,
      'minTemperature': 97.7
    },
    {
      'dateTime': DateTime.now(),
      'maxHeartRate': 86,
      'minHeartRate': 76,
      'maxTemperature': 99.5,
      'minTemperature': 98.1
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_data[index]['dateTime'].year}-${_data[index]['dateTime'].month}-${_data[index]['dateTime'].day} ${_data[index]['dateTime'].hour}:${_data[index]['dateTime'].minute}:${_data[index]['dateTime'].second}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Max Heart Rate: ${_data[index]['maxHeartRate']} bpm',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Min Heart Rate: ${_data[index]['minHeartRate']} bpm',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Max Temperature: ${_data[index]['maxTemperature']}°F',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Min Temperature: ${_data[index]['minTemperature']}°F',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
