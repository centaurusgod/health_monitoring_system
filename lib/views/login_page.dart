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
  bool _isLoading = false;

  bool _hidePassword = true;

  Stream<QuerySnapshot>? snapshotStream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 15, 0, 77),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("Login Screen"),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Color.fromARGB(255, 15, 0, 77),
              ))
            : SingleChildScrollView(
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
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 15, 0, 77),
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color.fromARGB(255, 15, 0, 77),
                            ),
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
                          obscureText: _hidePassword,
                          controller: loginpasswordController,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 15, 0, 77),
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.password,
                              color: Color.fromARGB(255, 15, 0, 77),
                            ),
                            suffixIcon: _hidePassword
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _hidePassword = !_hidePassword;
                                      });
                                    },
                                    child: Icon(
                                      Icons.visibility,
                                      color: Color.fromARGB(255, 15, 0, 77),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _hidePassword = !_hidePassword;
                                      });
                                    },
                                    child: Icon(
                                      Icons.visibility_off,
                                      color: Color.fromARGB(255, 15, 0, 77),
                                    ),
                                  ),
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
                      setState(() {
                        _isLoading = true;
                      });
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
                        alertDialogshowerOnFirebaseException(
                            error.code.toString());

                        setState(() {
                          _isLoading = false;
                        });
                      }
                      ;
                    },
                    child: Text("Login"),
                    style: ButtonStyle(backgroundColor:
                        MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) {
                      return Color.fromARGB(255, 15, 0, 77);
                    })),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(() => Forgetscreen());
                      },
                      style: ButtonStyle(backgroundColor:
                          MaterialStateColor.resolveWith(
                              (Set<MaterialState> states) {
                        return Color.fromARGB(255, 255, 17, 0);
                      })),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Forgot Password",
                          //  style: TextStyle(backgroundColor: Colors.white),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(() => Signup());
                      },
                      style: ButtonStyle(backgroundColor:
                          MaterialStateColor.resolveWith(
                              (Set<MaterialState> states) {
                        return Color.fromARGB(255, 15, 0, 77);
                      })),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Dont have an account? SignUp",
                          //  style: TextStyle(backgroundColor: Colors.white),
                        ),
                      )),
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
        setState(() {
          _isLoading = false;
        });
        Get.to(() => ChipIDValidator());
      } else {
        _query.docs.forEach((doc) {
          // nodeID.add(doc['myid']);
          //   print(doc["active"]);
          if (doc['active'] == "true") {
            activeDeviceID = doc['myid'];
            setState(() {
              _isLoading = false;
            });
            Get.to(() => NavBarPage());
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
  }

  alertDialogshowerOnFirebaseException(String errorCode) {
    // log(errorCode);
    switch (errorCode) {
      case 'wrong-password':
        returnAlertDialogOnError("Email or Password Incorrect");
        break;

      case 'unknown':
        returnAlertDialogOnError("Please Fill The Fields Correctly");
        break;

      case 'user-not-found':
        returnAlertDialogOnError("Email or Password Incorrect");
        break;
      case 'email-already-in-use':
        // log("Custom: The email is already used");
        // Code to handle the error
        returnAlertDialogOnError(
            'The email address is already in use by another account');
        // FocusScope.of(context).requestFocus(_focusNode);
        break;

      case 'invalid-email':
        returnAlertDialogOnError("Enter a valid email address");
        break;
      case 'weak-password':
        break;
      //default: errorDialog.returnAlertDialogOnError(context, errorCode); log("Default case ran"); break;
    }
  }

  returnAlertDialogOnError(String textValue) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(textValue),
          actions: [
            ElevatedButton(
              child: const Text("OK"),
              style: ButtonStyle(backgroundColor:
                  MaterialStateColor.resolveWith((Set<MaterialState> states) {
                return Color.fromARGB(255, 15, 0, 77);
              })),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
