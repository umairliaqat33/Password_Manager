// @dart=2.9
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:password_manager/models/database.dart';
import 'package:password_manager/screens/login_screen.dart';
import 'package:password_manager/screens/welcom_screen.dart';
import 'package:provider/provider.dart';

User user = FirebaseAuth.instance.currentUser;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // runApp(ChangeNotifierProvider(
  //     create: (context) => Transactions(), child: MyApp()));
  runApp(ChangeNotifierProvider(
    create: (context)=>Credentials(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Quicksand',
        primarySwatch: Colors.purple,
        primaryColor: Colors.purpleAccent,
      ),
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("You have an error ${snapshot.error.toString()}");
            return Text("Something went wrong");
          } else if (snapshot.hasData) {
            return MyHomePage();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Quicksand',
        primarySwatch: Colors.purple,
        primaryColor: Colors.purpleAccent,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => user == null ? LoginScreen() : WelcomeUserScreen(),
      },
    );
  }
}
