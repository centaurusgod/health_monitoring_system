import 'dart:async';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:vibration/vibration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: "Plots Live graph",
    home: RealTimeGraphRenderer("Heart"),
    debugShowCheckedModeBanner: false,
  ));
}

class RealTimeGraphRenderer extends StatefulWidget {
  final Key? key;
  final String vital;

  RealTimeGraphRenderer(this.vital, {this.key});
  @override
  State<StatefulWidget> createState() {
    return RealTimeGraphRendererState();
  }
}

class RealTimeGraphRendererState extends State<RealTimeGraphRenderer> {
//constructor for future use
  RealTimeGraphRendererState();

  final databaseReference = FirebaseDatabase.instance.ref('HEART_MEASURE');

  List<FlSpot> heartSpots = List.empty(growable: true);
  late double deviceHeight;
  late double deviceWidth;
  int status = 0;
  var timer;

  double dynamicMinY = 40;
  double dynamicMaxY = 180;
  int heartRate = 0;
  @override
  void initState() {
    generateCoordinatesHeart();
    heartRate = heartSpots[19].y.toInt();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.transparent,
        height: deviceHeight,
        width: deviceWidth,
        child: Padding(
          padding: EdgeInsets.only(top: deviceHeight / 18),
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: deviceHeight / 4.5,
                  height: deviceHeight / 4.5,
                  child: SleekCircularSlider(
                    // min: 0,
                    //maximum heartrate
                    max: 240,
                    innerWidget: (percentage) {
                      return Center(
                        child: Text(
                          "$heartRate bpm",
                          style: TextStyle(
                              fontSize: deviceHeight / 35,
                              color: Colors.orange,
                              fontWeight: FontWeight.w800),
                        ),
                      );
                    },
                    appearance: CircularSliderAppearance(
                        angleRange: 240,
                        customColors: CustomSliderColors(
                            dotColor: Colors.white,
                            progressBarColors: [
                              Color.fromARGB(255, 255, 17, 0),
                              Color.fromARGB(255, 255, 17, 0),
                              Color.fromARGB(255, 255, 17, 0),
                              Color.fromARGB(255, 255, 17, 0),
                              Color.fromARGB(255, 255, 17, 0),
                              Color.fromARGB(255, 255, 17, 0),
                              Color.fromARGB(255, 255, 17, 0),
                              Colors.orange,
                              Colors.orange,
                              Colors.orange,
                              Color.fromARGB(255, 255, 17, 0),
                              Color.fromARGB(255, 255, 17, 0),

                              //  Colors.orange,
                            ],
                            trackColors: [
                              Color.fromARGB(255, 255, 17, 0),
                              Color.fromARGB(255, 255, 98, 87),
                              Color.fromARGB(255, 255, 17, 0),
                              Color.fromARGB(255, 255, 98, 87),
                              Colors.orange,
                              Color.fromARGB(255, 255, 17, 0),
                              Color.fromARGB(255, 255, 98, 87),
                            ]),
                        customWidths: CustomSliderWidths(
                            progressBarWidth: 15, handlerSize: 4)),

                    //control the circle using this initialvalue
                    //from setstate or other builder
                    //i am keeping dummy value as 130 for now
                    initialValue: heartRate.toDouble(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text("Start Measuring"),
                        GestureDetector(
                          onTap: (() {
                            startUpdatingData();
                          }),
                          child: CircleAvatar(
                            radius: deviceHeight / 36,
                            backgroundColor: Colors.deepOrange,
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: deviceWidth / 14,
                    ),
                    Column(
                      children: [
                        StreamBuilder(
                          builder: (context, snapshot) {
                            return Text("Start Tracking Status: $status");
                          },
                        ),
                        GestureDetector(
                          onTap: (() async {
                            ///firebase functions, handleers, set realtime database value to turn on
                            try {
                              if (status == 0) {
                                databaseReference.update({"HEART_MEASURE": 1});
                              }
                              else{
                                  databaseReference.update({"HEART_MEASURE": 0});
                              }

                              readData();
                            } catch (error) {
                              print(error);
                            }

                            ///
                          }),
                          child: CircleAvatar(
                            radius: deviceHeight / 36,
                            backgroundColor: Colors.deepOrange,
                            child: Icon(
                              Icons.living_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: deviceHeight / 11,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: deviceWidth / 35, right: deviceWidth / 25),
                  child: Container(
                    height: deviceHeight / 2,
                    width: deviceWidth,
                    color: Colors.white,
                    child: LineChart(
                      LineChartData(
//the minimum and maximum value of this chart should be dynamic
//we shall receive data from the database and accordingly change
//the minimum and maximum range of values

                          minX: 0,
                          maxX: 20,
                          minY: dynamicMinY,
                          maxY: dynamicMaxY,
                          borderData: FlBorderData(
                              show: true,
                              border: Border(
                                top: BorderSide.none,
                                right: BorderSide.none,
                                bottom:
                                    BorderSide(color: Colors.black, width: 2.0),
                                left:
                                    BorderSide(color: Colors.white, width: 2.0),
                              )),
                          gridData: FlGridData(
                            drawVerticalLine: true,
                            drawHorizontalLine: true,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: Colors.black.withOpacity(0.2),
                                dashArray: [2, 2, 2],
                              );
                            },
                            getDrawingVerticalLine: (value) {
                              return FlLine(
                                color: Colors.white.withOpacity(0.05),
                                dashArray: [2, 2, 2],
                              );
                            },
                          ),

                          //backgroundColor: Colors.black,
                          lineBarsData: [
                            LineChartBarData(
                              isCurved: true,
                              color: Color.fromARGB(255, 255, 17, 0),
                              dotData: FlDotData(show: false),
                              barWidth: 3.0,
                              spots: heartSpots,
                              //[
                              //   const FlSpot(0, 70),
                              //   const FlSpot(1, 90),
                              //   const FlSpot(2, 85),
                              //   const FlSpot(3, 110),
                              //   const FlSpot(4, 120),
                              //   const FlSpot(5, 115),
                              //   const FlSpot(6, 135),
                              //   const FlSpot(7, 120),
                              // ],
                            ),
                          ],
                          titlesData: FlTitlesData(
                              topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              bottomTitles: mainData(),
                              leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                reservedSize: 30.0,
                                interval: 10,
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold),
                                  );
                                },
                              )))),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    ));
  }

  void readData() async {
    try {
      databaseReference.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value as Map;
        if (data != null) {
          print("neeeee");

          print(status);
          status = data['HEART_MEASURE'];

          // if (status == 1) {
          //   vibrateMyPhone();
          // }

          //  setState(() {

          //  });
        }

        // updateStarCount(data);
      });
    } catch (error) {
      print(error);
    }
  }

  vibrateMyPhone() async {
    Vibration.vibrate(duration: 2000);
  }

  AxisTitles mainData() {
    return AxisTitles(
        sideTitles: SideTitles(
      //  reservedSize: 400.0,

      showTitles: true,
      getTitlesWidget: (value, meta) {
        switch (value.toInt()) {
          case 0:
            return customStyleText("7");
          case 1:
            return customStyleText("6");
          case 2:
            return customStyleText("5");

          case 3:
            return customStyleText("4");
          case 4:
            return customStyleText("3");
          case 5:
            return customStyleText("2");
          case 6:
            return customStyleText("1");
          case 7:
            return customStyleText("RT");

          default:
            return customStyleText("");
        }
      },
    ));
  }

  //function to generte specific color text for button or any datats
  Text customStyleText(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: deviceHeight / 50),
    );
  }

//future functions to retrive realtime data from database

//fow now i shall use random number generator
  int generateRandomHeartBeat() {
    var random = Random();
    int randomInt = random.nextInt(15) + 85;
    return randomInt;
  }

  void generateCoordinatesHeart() {
    for (int i = 0; i < 20; i++) {
      //  print(i.toDouble() + generateRandomHeartBeat().toDouble());
      // heartY[i++] = generateRandomHeartBeat().toDouble();
      heartSpots
          .add(FlSpot(i.toDouble(), generateRandomHeartBeat().toDouble()));
    }
  }

  void startUpdatingData() {
    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      var tempListHeart = List<FlSpot>.empty(growable: true);

//gettng y values from the list FLspot
//now we shall create a new list from his values
//and add a new value at index 10
      int tempI = 0;
      for (int i = 0; i < 19; i++) {
        tempI++;
        tempListHeart.add(FlSpot(i.toDouble(), heartSpots[tempI].y));
      }
      int tempLastHeartbeat = generateRandomHeartBeat();
      heartRate = tempLastHeartbeat;
      tempListHeart.add(FlSpot(19, tempLastHeartbeat.toDouble()));

      // dynamicMaxY = (tempLastHeartbeat / 10).ceil() * 10+ 50;
      // dynamicMinY = (tempLastHeartbeat / 10).ceil() * 10- 50;

      heartSpots = tempListHeart;
      // Redraw the graph
      setState(() {});
    });
  }
}
