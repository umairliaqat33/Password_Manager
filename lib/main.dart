import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:password_manager/screens/password_creating_screen.dart';

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.purple),
        checkboxTheme: CheckboxThemeData(
          fillColor:
              MaterialStateColor.resolveWith((states) => Colors.purpleAccent),
          checkColor: MaterialStateColor.resolveWith((states) => Colors.white),
        ),
        primaryColor: Colors.purple,
      ),
      home: Scaffold(
        body: PasswordCreation(),
      ),
    );
  }
}
