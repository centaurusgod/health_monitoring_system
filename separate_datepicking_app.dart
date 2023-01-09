import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calender',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double deviceHeight = 0;
  double deviceWidth = 0;

  //use this to get only date value and trim time in seconds and miliseconds
  DateTime currentDate = DateTime.now();

var todaysDate = DateTime.now();
//var formattedDate = DateFormat.yMd(todaysDate);

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((value) => {

        setState(() {
          currentDate = value!;
        },)
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(currentDate.year.toString()+ "-"+currentDate.month.toString()+"-"+ currentDate.day.toString()),
              IconButton(
                onPressed: _showDatePicker,
                icon: Icon(Icons.calendar_month_outlined),
              ),
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
