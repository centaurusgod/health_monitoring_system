import 'dart:developer';

import 'package:application/views/forget.dart';
import 'package:application/views/mainscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:application/views/signscreen.dart';
import 'package:lottie/lottie.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  TextEditingController loginemailController=TextEditingController();
  TextEditingController loginpasswordController=TextEditingController();
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
              alignment:Alignment.center,
              height:300.0,
              child:Lottie.asset("assets/63787-secure-login.json"),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller:loginemailController,
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
                    controller:loginpasswordController,
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
            ElevatedButton(onPressed: ()async{ 
          var loginemail=loginemailController.text.trim();
           var loginpassword=loginpasswordController.text.trim();
try{
  final User? firebaseUser =(await FirebaseAuth.instance.signInWithEmailAndPassword(email: loginemail, password: loginpassword)).user;
  if (firebaseUser!=null){
    Get.to(()=>Mainscreen());
  }
}on FirebaseAuthException catch(error){
              log(error.toString());
             };

            }, child: Text("Login")),
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
}
