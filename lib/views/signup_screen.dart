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
  bool _isLoading = false;
  bool _hidePassword = true;

  User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 15, 0, 77),
          centerTitle: true,
          title: Text("Signup Screen"),
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
                    child: Lottie.asset("assets/106680-login-and-sign-up.json"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          controller: UsernameController,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 15, 0, 77),
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.contact_mail,
                              color: Color.fromARGB(255, 15, 0, 77),
                            ),
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
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 15, 0, 77),
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Color.fromARGB(255, 15, 0, 77),
                            ),
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
                          controller: PasswordController,
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
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        controller: ConfirmPasswordController,
                        obscureText: _hidePassword,
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
                        setState(() {
                          _isLoading = true;
                        });
                        if (_validatePassword()) {
                          log("if statement executed");
                          var userName = UsernameController.text.trim();
                          var phone = phoneController.text.trim();
                          var email = EmailController.text.trim();
                          var password = PasswordController.text.trim();
                          User? user;
                          try {
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: email, password: password)
                                .then((value) => {
                                      log("created email and pass"),
                                      user = FirebaseAuth.instance.currentUser,
                                      log("User Created"),
                                      FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(user?.uid)
                                          .set({
                                        'username': userName,
                                        'userphone': phone,
                                        'useremail': email,
                                        'createdAt': DateTime.now(),
                                        'userId': user?.uid,
                                      }).then((value) => {
                                                print(currentUser?.uid),
                                                Future.delayed(
                                                    Duration(seconds: 2)),
                                                _isLoading = false,
                                                Get.to(() => UserLoginPage()),
                                              }),
                                    });
                          } on FirebaseAuthException catch (error) {
                            alertDialogshowerOnFirebaseException(
                                error.code.toString());
                          }
                        }
                      },
                      style: ButtonStyle(backgroundColor:
                          MaterialStateColor.resolveWith(
                              (Set<MaterialState> states) {
                        return Color.fromARGB(255, 15, 0, 77);
                      })),
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

  //created this to check email at first by mistake
//so just didnt remove the code instead added a new lambda function
//to show alertdialoges
  returnAlertDialogOnEmailError(String value, String textValue) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Alert'),
            content: Text(textValue),
            actions: [
              ElevatedButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      // return 'Please enter a valid email address';
    }
    return null;
  }

  //showing alert dialog for various kind of error
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
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

//function to validate password
//and meet criteria for a strong password
//matching length etc
  bool _validatePassword() {
    // Minimum length
    String password = PasswordController.text.toString();
    if (password.length < 8) {
      returnAlertDialogOnError("Password must be at least 8 characters");
      return false;
    }
    if (PasswordController.text.toString() !=
        ConfirmPasswordController.text.toString()) {
      returnAlertDialogOnError("Password didnot match");
      return false;
    }

    // Must contain at least one lowercase letter, one uppercase letter, one digit, and one special character
    if (!RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
        .hasMatch(password)) {
      returnAlertDialogOnError(
          "Use symbol, character, number, uppercase, lowercase in your password");
      return false;
    }

    // Cannot contain the username
    // Replace this with your own logic to check for the username
    if (password.contains(EmailController.text.toString())) {
      returnAlertDialogOnError("Password cannot be Email");
      return false;
    }

    // Passwords that are too common are not allowed
    // Replace this with your own logic to check for common passwords
    if (['password', '123456', 'qwerty'].contains(password)) {
      returnAlertDialogOnError("Very weak password");
      return false;
    }

    return true;
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
}
