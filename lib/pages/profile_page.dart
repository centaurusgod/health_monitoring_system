import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:live_graph_plotter/views/forget.dart';

import '../views/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController chipIDController = TextEditingController();

  String activeDeviceID = "";

  @override
  void initState() {
    //super.initState;
    checkForNodeID();
    super.initState();
  }

  getUserEmail() {
    User? user;
    user = FirebaseAuth.instance.currentUser;
    return user!.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   // centerTitle: true,
      //   title: Text(
      //     'My Profile',
      //     style: TextStyle(color: Colors.red, fontSize: 25),
      //   ),
      //   leading: IconButton(
      //     icon: Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.red,
      //     ),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     color: Colors.black,
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Circle Avatar and email
            SizedBox(
              height: 50,
            ),
            Center(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 40,
                    child: Text(
                      getUserEmail()[0].toUpperCase(),
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    getUserEmail(),
                    style: TextStyle(fontSize: 20.0),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
            //   child: Divider(
            //     color: Colors.black,
            //   ),
            // ),
            SizedBox(
              height: 30,
            ),
            //cards

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //device id
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: Card(
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Your Device : $activeDeviceID',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text("Chip ID"),
                                          content:
                                              const Text("Enter your Chip ID"),
                                          actions: [
                                            TextField(
                                              controller: chipIDController,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              decoration: InputDecoration(
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Theme.of(context)
                                                              .primaryColor),
                                                      borderRadius: BorderRadius.circular(
                                                          20)),
                                                  errorBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(
                                                          color: Colors.red),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Theme.of(context)
                                                              .primaryColor),
                                                      borderRadius: BorderRadius.circular(20))),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _checkForHardwareID();
                                                    });
                                                  },
                                                  child: Text('SAVE')),
                                            )
                                          ],
                                        );
                                      });
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Colors.grey,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),

                  //change password
                  GestureDetector(
                    onTap: () {
                      Get.to(() => Forgetscreen());
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: Card(
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15),
                          child: Text(
                            'Change Password ',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),

                  //logout

                  GestureDetector(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Get.off(() => UserLoginPage());
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: Card(
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15),
                          child: Text(
                            'Logout ',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  checkForNodeID() async {
    List<String> nodeID = List.empty(growable: true);
    final user = FirebaseAuth.instance.currentUser;

    try {
      QuerySnapshot<Map<String, dynamic>> _query = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user?.uid)
          .collection('Nodes')
          .get();

      if (_query.docs.isEmpty) {
        //  Get.to(() => ChipIDValidator());
        log("No Chip IDdata present");
      } else {
        _query.docs.forEach((doc) {
          // nodeID.add(doc['myid']);
          //   print(doc["active"]);
          if (doc['active'] == "true") {
            setState(() {
              activeDeviceID = doc['myid'];
            });

            print(activeDeviceID);
            // Get.to(() => NavBarPage(
            //       currentActiveId: activeDeviceID,
            //     ));
          }

          // log("error");
        });
      }

      // log("Statement copleted totally");
    } catch (error) {
      print("No Such Data");
    }
    // log(activeDeviceID);

    //log(userID);
    //  return activeDeviceID;
  }

  _checkForHardwareID() async {
    final user = FirebaseAuth.instance.currentUser;
    print(user?.uid);
    bool hardwareExists = false;
    try {
      QuerySnapshot<Map<String, dynamic>> _query =
          await FirebaseFirestore.instance.collection('NodeID').get();

      if (_query.docs.isEmpty) {
        log("no data");
        //  CircularProgressIndicator();
      } else {
        _query.docs.forEach((doc) {
          // nodeID.add(doc['myid']);
          //   print(doc["active"]);
          if (doc['id'] == chipIDController.text) {
            hardwareExists = true;
          }
          // log("error");
        });
      }
      if (hardwareExists) {
        log("hardware  exists");
//create document nodes with hardware id and set 2 param
//1 hardware id as my id itself and othe parameter as active
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user?.uid)
            .collection("Nodes")
            .doc(chipIDController.text)
            .set({
          'myid': chipIDController.text,
          'active': "true",
        }).then((value) {
          FirebaseFirestore.instance
              .collection("users")
              .doc(user?.uid)
              .collection("Nodes")
              .doc(activeDeviceID)
              .set({
            'myid': activeDeviceID,
            'active': "false",
          });

          checkForNodeID();

          Navigator.of(context).pop();
          showSnackBar(context, Colors.green, "Saved & Set Sucessfully");
        });
      } else {
        Navigator.of(context).pop();
        log("hardware does not exists");
        showSnackBar(context, Colors.red, "Invalid Device");
      }
    } catch (error) {
      print(error);
    }
  }

  void showSnackBar(context, color, message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 14),
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
          textColor: Colors.white,
        ),
      ),
    );
  }
}
