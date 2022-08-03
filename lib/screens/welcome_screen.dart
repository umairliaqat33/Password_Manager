import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:password_manager/screens/screen_shifter.dart';
import 'package:password_manager/widgets/logo_widget.dart';

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
          context, MaterialPageRoute(builder: (context) => Shifter()));
    });
  }

  @override
  void initState() {
    super.initState();
    getValues();
    Time();
  }

  void getValues() {
    try {
      if (user != null) {
        FirebaseFirestore.instance
            .collection("Users")
            .doc(user!.uid)
            .get()
            .then((value) {
          setState(() {
            name = value.get('userName');
          });
        });
      }
    } catch (e) {
      log(e.toString());
      Fluttertoast.showToast(msg: e.toString());
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
            Hero(
              tag: 'logo',
              child: LogoWidget(),
            ),
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
