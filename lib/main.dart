import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:live_graph_plotter/pages/nav_bar_page.dart';
import 'views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;

    //  _checkForNodeID();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (user != null) ? NavBarPage() : UserLoginPage(),
    );
  }

  // _checkForNodeID() async {
  //   final user = FirebaseAuth.instance.currentUser;

  //   try {
  //     QuerySnapshot<Map<String, dynamic>> _query = await FirebaseFirestore
  //         .instance
  //         .collection('users')
  //         .doc(user?.uid)
  //         .collection('Nodes')
  //         .get();
  //     if (_query.docs.isEmpty) {
  //       log("no data");
  //       //// Get.to(() => ChipIDValidator());                                                                                                                                                                                                                                                                                                                                                                                                                                                                      s
  //     } else {
  //       _query.docs.forEach((doc) {
  //         // nodeID.add(doc['myid']);
  //         //   print(doc["active"]);
  //         if (doc['active'] == "true") {
  //           setState(() {
  //             activeDeviceID = doc['myid'];
  //           });
  //         }

  //         // log("error");
  //       });
  //     }

  //     // log("Statement copleted totally");
  //   } catch (error) {
  //     print("No Such Data");
  //   }
  // }
}
