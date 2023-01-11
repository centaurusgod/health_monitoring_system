import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

void main() {
  runApp(MaterialApp(
    title: "Circular progress indicator",
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int angle = 0;
  double sliderValue = 0.0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: Stack(children: [
            Positioned(
              top: 100,
              child: Slider(
                //  / inactiveColor: Colors.white,
                value: sliderValue,
                onChanged: (value) {
                  setState(() {
                    sliderValue = value;
                    print(sliderValue);
                    angle = (240 * sliderValue).toInt();
                  });
                },
              ),
            ),
            RotatedBox(
              quarterTurns:3,
              child: ShaderMask(
                shaderCallback: (rect) {
                  return SweepGradient(
                      startAngle: 0,
                      endAngle: 2 * pi,
                      stops: [sliderValue, sliderValue],
                      // 0.0 , 0.5 , 0.5 , 1.0
                      center: Alignment.center,
                      colors: [
                        Colors.orange,
                        Color.fromARGB(255, 255, 17, 0)
                      ]).createShader(rect);
                },
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white,
                        
                    //  /   image: DecorationImage(image: Image.asset('assets/images/image.png').image)
                        
                        ),
                  ),
                ),
              ),
            ),

            Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 2.6,
                height: MediaQuery.of(context).size.height / 4,
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: Center(
                    child: Text(
                  "$angle",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),


        
          ]),
        ),
      ),
    ));
  }
}
