import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../pages/nav_bar_page.dart';
import 'chip_id_page.dart';
import 'forget.dart';
import 'signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  TextEditingController loginemailController = TextEditingController();
  TextEditingController loginpasswordController = TextEditingController();
  final _user = FirebaseAuth.instance.currentUser ?? null;

  Stream<QuerySnapshot>? snapshotStream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("Login Screen"),
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Column(children: [
            Container(
              alignment: Alignment.center,
              height: 300.0,
              child: Lottie.asset("assets/63787-secure-login.json"),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: loginemailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Email',
                      enabledBorder: OutlineInputBorder(),
                    ),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: loginpasswordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: Icon(Icons.visibility),
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder(),
                    ),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  var loginemail = loginemailController.text.trim();
                  var loginpassword = loginpasswordController.text.trim();
                  try {
                    final User? firebaseUser = (await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: loginemail, password: loginpassword))
                        .user;
                    if (firebaseUser != null) {
                      //check if the user already owns a device
                      _checkForNodeID();

                      //    Get.to(() => NavBarPage());
                    }
                  } on FirebaseAuthException catch (error) {
                    log(error.toString());
                  }
                  ;
                },
                child: Text("Login")),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => Forgetscreen());
              },
              child: Container(
                  child: Card(
                      child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Forgot Password"),
              ))),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => Signup());
              },
              child: Container(
                  child: Card(
                      child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Dont have an account Signup"),
              ))),
            )
          ]),
        )));
  }

  Future<void> _checkForNodeID() async {
    List<String> nodeID = List.empty(growable: true);
    final user = FirebaseAuth.instance.currentUser;
    late String activeDeviceID;
    try {
      QuerySnapshot<Map<String, dynamic>> _query = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user?.uid)
          .collection('Nodes')
          .get();
      if (_query.docs.isEmpty) {
        log("no data");
        CircularProgressIndicator();
        Get.to(() => ChipIDValidator());
      } else {
        _query.docs.forEach((doc) {
          // nodeID.add(doc['myid']);
          //   print(doc["active"]);
          if (doc['active'] == "true") {
            activeDeviceID = doc['myid'];
          }
          Get.to(() => NavBarPage(
                currentActiveId: activeDeviceID,
              ));
          // log("error");
        });
      }

      // log("Statement copleted totally");
    } catch (error) {
      print("No Such Data");
    }
    // log(activeDeviceID);

    //log(userID);
  }
}
