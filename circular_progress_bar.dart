//required flutter pub add sleek_circular_slider
// import 'package:sleek_circular_slider/sleek_circular_slider.dart';


SleekCircularSlider(
                  // min: 0,
                  //maximum heartrate 
                  max: 240,
                  innerWidget: (percentage) {
                    return Center(
                      child: Text(
                        "120 bpm",
                        style: TextStyle(
                            fontSize: 45.0,
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
                  initialValue: 130.0,
                ),
