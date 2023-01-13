import 'dart:developer';

import 'package:application/views/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Forgetscreen extends StatefulWidget {
  const Forgetscreen({super.key});

  @override
  State<Forgetscreen> createState() => ForgetscreenState();
}

class ForgetscreenState extends State<Forgetscreen> {
  TextEditingController forgetController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      centerTitle: true,
      title:Text("Forget Screen"),
    ),
    body: SingleChildScrollView(child:Container(
      child: Column(children: [
         Container(
              alignment:Alignment.center,
              height:300.0,
              child:Lottie.asset("assets/75988-forgot-password.json"),
            ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            margin:EdgeInsets.symmetric(horizontal:30),
            child:TextFormField(
              controller: forgetController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText:'Email',
                enabledBorder: OutlineInputBorder(),
              ),
            )
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(onPressed: ()async{
          var forgetEmail=forgetController.text.trim();
          try{
  await FirebaseAuth.instance.sendPasswordResetEmail(email: forgetEmail).then((Value)=> {
  log("Email sent"),
 Get.off(()=>Homescreen()) ,
 });
        }  on FirebaseAuthException catch(error){
              log(error.toString());
             }
        },
        child:Text("Forget Password  ")),
        SizedBox(
          height: 10,
        ),
      ]),
    )));
  }
}