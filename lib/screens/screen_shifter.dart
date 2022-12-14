import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/data_screens/add_credentials.dart';
import 'package:password_manager/screens/list_screen.dart';
import 'package:password_manager/data_screens/signOut_alert_dialogue.dart';
import 'package:password_manager/models/database.dart';
import 'package:password_manager/screens/password_creating_screen.dart';
import 'package:provider/provider.dart';

import '../data_screens/search_dialogue.dart';

class Shifter extends StatefulWidget {
  @override
  State<Shifter> createState() => _ShifterState();
}

class _ShifterState extends State<Shifter> {
  String name = "";

  getName() {
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
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Credentials>(builder: (context, credentials, child) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AddCredentials();
                  });
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
            automaticallyImplyLeading: false,
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () async {
                  getName();
                  creatingSignOutAlertDialog(context, name);
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
                  icon: Icon(Icons.password),
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
