import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class OxygenSaturation extends StatefulWidget {
  const OxygenSaturation({super.key});

  @override
  State<OxygenSaturation> createState() => _OxygenSaturationState();
}

class _OxygenSaturationState extends State<OxygenSaturation> {
  late String oxygenSaturation;
  final databaseReference = FirebaseDatabase.instance.ref('5166519');
  var timer;
  @override
  void initState() {
    oxygenSaturation = "95";
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
        appBar: AppBar(
          title: Text("Oxygen Saturation"),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 15, 0, 77),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: (() {
                    setState(() {
                      startUpdatingData();
                    });
                  }),
                  child: Icon(Icons.health_and_safety)),
              StreamBuilder(
                stream: readData(),
                builder: (context, snapshot) {
                  return Text(
                    " $oxygenSaturation %",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontFamily: 'VisbyRound',
                      fontSize: 45.0,
                      color: Colors.red,
                    ),
                  );
                },
              ),
            ],
          ),
        ));
    
  }

  readData() {
    int heart = 0, temp = 0;
    print("inside fun");
    try {
      databaseReference.onValue.listen((DatabaseEvent event) {
        Map data = event.snapshot.value as Map;
        temp = int.parse(data['TEMP_VALUE']);
        heart = int.parse(data['HEART_VAL']);
        print(temp);
        print(heart);

        if ((heart >= 40 && heart <= 100) && (temp >= 25.5 && temp <= 37.5)) {
          print("oxygennnnn");
          oxygenSaturation = "95-100";
        } else if ((heart >= 101 && heart <= 109) &&
            (temp > 37.5 && temp <= 38)) {
          oxygenSaturation = "91-95 ";
        } else if ((heart >= 110 && heart <= 130) &&
            (temp > 38 && temp <= 39)) {
          oxygenSaturation = "90";
        } else if ((heart >= 110 && heart <= 130) &&
            (temp > 38 && temp <= 39)) {
          oxygenSaturation = "90";
        } else {
          oxygenSaturation = "Measuring..";
        }

        print(oxygenSaturation);
        setState(() {});
      });
    } catch (error) {
      print(error);
    }
  }

  void startUpdatingData() {
    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      readData();
    });
  }
}
