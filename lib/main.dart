import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late TextEditingController textController=TextEditingController();
  String copiedText="";
  @override
  String generateRandomString(int length) {
    Random _random = Random();
    const _availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(length,
            (index) => _availableChars[_random.nextInt(_availableChars.length)])
        .join();

    return randomString;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                label: Text("Your Password"),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)
                ),
              ),
              obscureText: false,
              enabled: false,
              controller: textController,
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    generateRandomString(10);
                    setState(() {
                      textController=TextEditingController(text: generateRandomString(10));
                    });
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.white),
                    backgroundColor:
                        MaterialStateColor.resolveWith((states) => Colors.blue),
                  ),
                  child: Text("Generate"),
                ),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: textController.text));
                    Fluttertoast.showToast(msg: "Text Copied");
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.white),
                    backgroundColor:
                        MaterialStateColor.resolveWith((states) => Colors.blue),
                  ),
                  child: Text("Copy"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
