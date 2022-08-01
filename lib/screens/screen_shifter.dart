import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:password_manager/data_screens/list_screen.dart';
import 'package:password_manager/models/database.dart';
import 'package:password_manager/screens/password_creating_screen.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class Shifter extends StatefulWidget {
  @override
  State<Shifter> createState() => _ShifterState();
}

class _ShifterState extends State<Shifter> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Credentials>(builder: (context, Transactions, child) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              print("helow");
            },
            child: Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  Colors.purple,
                  Colors.red,
                ], begin: Alignment.topRight, end: Alignment.topLeft),
              ),
              child: Icon(
                Icons.add,
              ),
            ),
          ),
          appBar: AppBar(
            elevation: 20,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.purple,
                  Colors.red,
                ], begin: Alignment.bottomRight, end: Alignment.topLeft),
              ),
            ),
            title: Text("Password Manager"),
            actions: [
              IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Fluttertoast.showToast(msg: "SignOutSuccessful");
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen())).catchError((e) {
                    Fluttertoast.showToast(msg: e);
                  });
                },
                icon: Icon(Icons.logout),
              ),
            ],
            bottom: TabBar(
              isScrollable: true,
              indicatorWeight: 5,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.white, width: 3),
              ),
              tabs: [
                Tab(
                  text: "Password List",
                  icon: Icon(Icons.list),
                ),
                Tab(
                  text: "Password Generator",
                  icon: Icon(Icons.list),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              PasswordList(),
              PasswordCreation(),
            ],
          ),
        ),
      );
    });
  }
}
