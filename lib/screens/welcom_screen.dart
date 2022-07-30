import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:password_manager/screens/password_creating_screen.dart';

class WelcomeUserScreen extends StatefulWidget {
  @override
  State<WelcomeUserScreen> createState() => _WelcomeUserScreenState();
}

class _WelcomeUserScreenState extends State<WelcomeUserScreen> {
  final user = FirebaseAuth.instance.currentUser;
  String name = '';

  Time() {
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => PasswordCreation()));
    });
  }

  @override
  void initState() {
    super.initState();
    getValues();
    Time();
  }

  void getValues() {
    if(user!=null){
      FirebaseFirestore.instance
          .collection("Users")
          .doc(user!.uid)
          .get()
          .then((value) {
        setState(() {
          name = value.get('Name');
        });
      });
    }else{
      GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['Email']);
      name=_googleSignIn.currentUser!.displayName!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Hero(
            //   tag: 'logo',
            //   child: Image.asset('assets/images/logo.png'),
            // ),
            Text(
              "Welcome",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                fontFamily: 'Quicksand',
              ),
            ),
            Text(
              "$name",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                fontFamily: 'Quicksand',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
