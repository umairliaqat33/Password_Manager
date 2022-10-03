// @dart=2.9

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:password_manager/models/database.dart';
import 'package:password_manager/screens/login_screen.dart';
import 'package:password_manager/screens/password_creating_screen.dart';
import 'package:password_manager/screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
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
            log("You have an error ${snapshot.error.toString()}");
            return Text("Something went wrong");
          } else if (snapshot.hasData) {
            return PasswordCreation();
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
