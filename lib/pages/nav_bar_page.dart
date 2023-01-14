import 'package:flutter/material.dart';
import 'package:live_graph_plotter/pages/profile_page.dart';
import 'package:live_graph_plotter/pages/user_home_page.dart';
import 'graph_log.dart';

//import 'package:intl/intl.dart';
class NavBarPage extends StatefulWidget {
  final currentActiveId;
  const NavBarPage({super.key, required this.currentActiveId});

  @override
  State<NavBarPage> createState() => _NavBarPageState(currentActiveId);
}

class _NavBarPageState extends State<NavBarPage> {
  _NavBarPageState(currentActiveId) {
    this.basecurrentActiveId = currentActiveId;
  }

  late String basecurrentActiveId;
  // String getCurrentDate() {
  //   var now = DateTime.now();
  //   //var formatter = DateFormat(' MMMM d, y');
  //   return formatter.format(now);
  // }

  late double deviceHeight;
  late double deviceWidth;
  int trackHeartStatus = 0;

  int selectedIndex = 0;

  final List<Widget> children = [
    UserHomePage(),
    LogsPage(),
    LogsPage(),
    ProfilePage(currentActiveID: ""),
  ];

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    print("deviceHeight:" + deviceHeight.toString());
    print("Width:" + deviceWidth.toString());
    return Expanded(
      child: Scaffold(
        body: children[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 15, 0, 77),

          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
              if (index == 3)
                children[index] =
                    ProfilePage(currentActiveID: widget.currentActiveId);
              else
                children[index] = children[index];
            });
          },
          // onTap:

          //elevation: 0,
          iconSize: 25.0,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(
                  Icons.home_rounded,
                  // color: Colors.white,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(
                  Icons.search_rounded, //color: Colors.white,
                ),
                // title: Text('Search'),
                label: "Logs"),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notification_important,
                //color: Colors.white,
              ),
              label: "Alerts",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                //color: Colors.white,
              ),
              label: "Profile",
            ),
          ],
          //   currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          selectedFontSize: 14.0,
          unselectedFontSize: 14.0,
          selectedIconTheme: IconThemeData(color: Colors.white),
          unselectedIconTheme: IconThemeData(color: Colors.white),
          selectedLabelStyle: TextStyle(
            color: Colors.white,
            fontFamily: 'ProximaNova',
            fontWeight: FontWeight.w800,
          ),
          unselectedLabelStyle: TextStyle(
            color: Colors.white,
            fontFamily: 'ProximaNova',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
