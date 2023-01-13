import 'package:application/views/homescreen.dart';
import 'package:application/views/mainscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lottie/lottie.dart';


void main()async{
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
  void iniState(){
    super.initState();
    user=FirebaseAuth.instance.currentUser;
    print(user?.uid.toString());
  }
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: user!=null? const Mainscreen():const Homescreen(),
    );
  }
}
