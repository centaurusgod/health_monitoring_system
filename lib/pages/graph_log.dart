import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LogsPage extends StatefulWidget {
  const LogsPage({super.key});

  @override
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  @override
  void initState() {
    _loadData();
    presentDate = getCurrentDate();
    super.initState();
  }

  late List<DropdownMenuItem<String>> _dropDownMenuItems;
  late String _selectedValue;
  DateTime currentDate = DateTime.now();
  String presentDate = "";
  late double deviceHeight;
  late double deviceWidth;

  String getCurrentDate() {
    var now = DateTime.now();
    var formatter = DateFormat(' MMMM d, y');
    return formatter.format(now);
  }

  String formattedDate(DateTime now) {
    var formatter = DateFormat(' MMMM d, y');
    return formatter.format(now);
  }

//date picker using calender action

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        //after we press oke then we are setting state to do something
        //in this case we are simply changinf vlaue of a text widget
        .then((value) => {
              setState(
                () {
                  //null safety ! mark
                  currentDate = value!;
                  presentDate = formattedDate(currentDate);
                  print("after formation");
                },
              )
            });
  }
  //

  void _loadData() {
    _dropDownMenuItems = [
      DropdownMenuItem(
        value: 'item1',
        child: Text('Item 1'),
      ),
      DropdownMenuItem(
        value: 'item2',
        child: Text('Item 2'),
      ),
      DropdownMenuItem(
        value: 'item3',
        child: Text('Item 3'),
      ),
    ];
    _selectedValue = _dropDownMenuItems[0].value!;
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        title: Text(
          'Logs',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                _showDatePicker();
              },
              child: Icon(
                Icons.calendar_month,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //current date
                Text(presentDate),
                // DropdownButton(items: items, onChanged: onChanged),
                DropdownButton(
                  value: _selectedValue,
                  items: _dropDownMenuItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value!;
                    });
                  },
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: deviceWidth / 35, right: deviceWidth / 30),
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
                      maxX: 8,
                      minY: 40,
                      maxY: 120,
                      borderData: FlBorderData(
                          show: true,
                          border: Border(
                            top: BorderSide.none,
                            right: BorderSide.none,
                            bottom: BorderSide(color: Colors.black, width: 1.0),
                            left: BorderSide(color: Colors.black, width: 1.0),
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
                            color: Colors.black.withOpacity(0.05),
                            dashArray: [2, 2, 2],
                          );
                        },
                      ),

                      //backgroundColor: Colors.black,
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          color: Color.fromARGB(255, 255, 17, 0),
                          // gradient: const LinearGradient(
                          //   begin: Alignment.topLeft,
                          //   end: Alignment.bottomRight,
                          //   colors: [
                          //     Colors.amber,
                          //     Colors.red,
                          //     Color.fromARGB(255, 238, 15, 175)
                          //   ],
                          // ),
                          belowBarData: BarAreaData(
                            show: true,
                            //color: Colors.red.withOpacity(0.2),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromARGB(60, 255, 17, 0),
                                Color.fromARGB(60, 255, 255, 255),
                                // Colors.red,
                                // Color.fromARGB(255, 238, 15, 175)
                              ],
                            ),
                          ),
                          dotData: FlDotData(show: false),
                          barWidth: 2.0,
                          spots: [
                            FlSpot(0, 80),
                            FlSpot(1, 85),
                            FlSpot(2, 80),
                            FlSpot(4, 85),
                            FlSpot(5, 80),
                            FlSpot(6, 85),
                            FlSpot(7, 80),
                            FlSpot(8, 80),
                          ],
                        ),
                      ],
                      titlesData: FlTitlesData(
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(
                            showTitles: false,
                          )),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  showTitles: false, reservedSize: 0)),
                          //   bottomTitles: mainData(),
                          leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                            reservedSize: deviceWidth / 17,
                            interval: 10,
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: deviceHeight / 60,
                                    fontFamily: 'VisbyRound',
                                    fontWeight: FontWeight.bold),
                              );
                            },
                          )))),
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            //graph

            //heart range, highest heart range, lowest heart range
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Heart rate range'),
                        Text(
                          '76-104  times/min',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Highest heart rate: '),
                        Text('Lowest heart rate: '),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
