import 'dart:developer';
import 'login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
  TextEditingController UsernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController ConfirmPasswordController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Signup Screen"),
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Column(children: [
            Container(
              alignment: Alignment.center,
              height: 300.0,
              child: Lottie.asset("assets/106680-login-and-sign-up.json"),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: UsernameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.contact_mail),
                      hintText: 'Username',
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
                    controller: phoneController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      hintText: 'phone',
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
                    controller: EmailController,
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
                    controller: PasswordController,
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
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: ConfirmPasswordController,
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: Icon(Icons.visibility),
                    hintText: 'Confirm Password',
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (ConfirmPasswordController.text ==
                      PasswordController.text) {
                    var Username = UsernameController.text.trim();
                    var phone = phoneController.text.trim();
                    var email = EmailController.text.trim();
                    var password = PasswordController.text.trim();
                    late final user;
                    ;
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: email, password: password)
                          .then((value) => {
                                user = FirebaseAuth.instance.currentUser,
                                log("User Created"),
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(user.uid)
                                    .set({
                                  'username': Username,
                                  'userphone': phone,
                                  'useremail': email,
                                  'createdAt': DateTime.now(),
                                  'userId': user.uid,
                                }).then((value) => {
                                          //  print(currentUser?.uid),
                                          Get.to(() => UserLoginPage()),
                                        }),
                              });
                    } on FirebaseAuthException catch (error) {
                      log(error.toString());
                    }
                    ;
                  } else {
                    print("Password doesnot match");
                  }
                },
                child: Text("SignUp")),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => UserLoginPage());
              },
              child: Container(
                  child: Card(
                      child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Already  have an account Sign In"),
              ))),
            ),
          ]),
        )));
  }
}
