import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/screens/password_creating_screen.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
