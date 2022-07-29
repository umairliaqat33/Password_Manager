import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:password_manager/models/constants.dart';
import 'package:password_manager/models/credentials.dart';
import 'package:password_manager/screens/welcom_screen.dart';

import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final C_pass_controller = TextEditingController();
  final name_Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  bool isLoginError = false;
  String errorMessage = "Something Went Wrong Please Try again";
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.purple,
          ),
          onPressed: () {
            // Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) => WelcomeScreen()));
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Hero(
                  //   tag: 'logo',
                  //   child: Container(
                  //     height: 200.0,
                  //     child: Image.asset('assets/images/logo.png'),
                  //   ),
                  // ),
                  Visibility(
                    visible: isLoginError,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        errorMessage,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name is required";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    cursorColor: Colors.purpleAccent,
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                    controller: name_Controller,
                    decoration: kMessageTextFieldDecoration.copyWith(
                      hintText: 'Enter Your Full Name',
                      icon: Icon(Icons.account_circle),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field required";
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    cursorColor: Colors.purple,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                    controller: emailController,
                    decoration: kMessageTextFieldDecoration.copyWith(
                      hintText: 'Enter Your Email',
                      icon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      RegExp regex = new RegExp(r"^.{8,}$");
                      if (value!.isEmpty) {
                        return "Field is required";
                      }
                      if (!regex.hasMatch(value)) {
                        return "Password must contain 8 characters minimum";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    cursorColor: Colors.purple,
                    textAlign: TextAlign.center,
                    obscureText: _passwordVisible,
                    style: TextStyle(color: Colors.black),
                    controller: passController,
                    decoration: kMessageTextFieldDecoration.copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      hintText: 'Enter Your Password',
                      icon: Icon(Icons.key),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field is required";
                      }
                      if (value != passController.text) {
                        return "Password do not match try again";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    cursorColor: Colors.purple,
                    textAlign: TextAlign.center,
                    obscureText: _passwordVisible,
                    style: TextStyle(color: Colors.black),
                    controller: C_pass_controller,
                    decoration: kMessageTextFieldDecoration.copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      hintText: 'Confirm Password',
                      icon: Icon(Icons.key),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      color: Colors.purple,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      elevation: 5.0,
                      child: MaterialButton(
                        onPressed: () {
                          SignUp(emailController.text, passController.text);
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        splashColor: null,
                        minWidth: 200.0,
                        height: 42.0,
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Already have an account? '),
                      TextButton(
                        style: ButtonStyle(
                            splashFactory: NoSplash
                                .splashFactory //removing onclick splash color
                            ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text("LogIn"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void SignUp(String email, String password) async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          showSpinner = true;
        });
        sleep(const Duration(seconds: 5));
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          postDetailsToFireStore();
        }).catchError((e) {
          if (e.toString() ==
              "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
            setState(() {
              errorMessage = "Email already in use";
            });
          }
          setState(() {
            showSpinner = false;
          });
          setState(() {
            isLoginError = true;
          });
        });
      } else {
        setState(() {
          showSpinner = false;
        });
        sleep(const Duration(seconds: 5));
        setState(() {
          isLoginError = true;
        });
      }
    } catch (e) {
      setState(() {
        showSpinner = false;
      });
      setState(() {
        isLoginError = true;
      });
    }
  }

  postDetailsToFireStore() async {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = _auth.currentUser;
      UserModel userModel = UserModel();
      userModel.email = user!.email;
      userModel.name = name_Controller.text;
      userModel.id = user.uid;
      await firebaseFirestore
          .collection('Users')
          .doc(user.uid)
          .set(userModel.toMap());

      Fluttertoast.showToast(msg: "Account Created Successfully");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => WelcomeUserScreen()));
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
