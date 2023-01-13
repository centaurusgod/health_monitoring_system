import 'package:application/views/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class Mainscreen extends StatelessWidget {
  const Mainscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Main Screen"),
        actions:[
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Get.off(()=>Homescreen());
            },
            child: Icon(Icons.logout))],)
    );
  }
}