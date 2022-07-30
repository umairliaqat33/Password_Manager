import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:password_manager/screens/login_screen.dart';

class PasswordCreation extends StatefulWidget {
  const PasswordCreation({Key? key}) : super(key: key);

  @override
  State<PasswordCreation> createState() => _PasswordCreationState();
}

class _PasswordCreationState extends State<PasswordCreation> {
  late TextEditingController textController = TextEditingController();
  int length = 8;
  bool isBoxErrorVisible = false;
  bool isCopyErrorVisible = false;
  String generatedString = "";
  bool isCharacter = true;
  bool isNumbers = true;
  bool isSpecialCharacters = true;
  static const String chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  static const String numbers = '1234567890';
  static const String specialCharacters = '!@#\\\$%^&*()_+/.,`';

  void selectText() {
    if (isCharacter == true &&
        isSpecialCharacters == true &&
        isNumbers == true) {
      randomCharString(length, chars + specialCharacters + numbers);
    } else {
      if (isCharacter == true) {
        if (isNumbers == true) {
          randomCharString(length, chars + numbers);
        } else if (isSpecialCharacters == true) {
          randomCharString(length, chars + specialCharacters);
        } else {
          randomCharString(length, chars);
        }
      } else if (isNumbers == true) {
        if (isCharacter == true) {
          randomCharString(length, chars + numbers);
        } else if (isSpecialCharacters == true) {
          randomCharString(length, numbers + specialCharacters);
        } else {
          randomCharString(length, numbers);
        }
      } else if (isSpecialCharacters == true) {
        if (isCharacter == true) {
          randomCharString(length, chars + specialCharacters);
        } else if (isNumbers == true) {
          randomCharString(length, numbers + specialCharacters);
        } else {
          randomCharString(length, specialCharacters);
        }
      } else {
        textController.clear();
        setState(() {
          isBoxErrorVisible = true;
        });
      }
    }
  }

  void randomCharString(int length, String text) {
    Random _random = Random();

    final randomString =
        List.generate(length, (index) => text[_random.nextInt(text.length)])
            .join();
    setState(() {
      textController.text = randomString;
    });
  }

  @override
  void initState() {
    selectText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Password Manager"),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // GoogleSignIn _googleSignIn=GoogleSignIn(scopes: ['Email']);
              // if(_googleSignIn.currentUser!=null){
              //   _googleSignIn.signOut();
              // }
              Fluttertoast.showToast(msg: "SignOutSuccessful");
              Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()))
                  .catchError((e) {
                Fluttertoast.showToast(msg: e);
              });
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    label: Text(
                      "Your Password",
                      style: TextStyle(color: Colors.purple),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                  ),
                  // obscureText: false,
                  enabled: false,
                  controller: textController,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: isCopyErrorVisible,
                child: Text(
                  "Please generate password first",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isBoxErrorVisible = false;
                      });
                      selectText();
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.purple),
                    ),
                    child: Text("Generate"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      if (!textController.text.isEmpty) {
                        Clipboard.setData(
                            ClipboardData(text: textController.text));
                        Fluttertoast.showToast(msg: "Text Copied");
                        setState(() {
                          isCopyErrorVisible = false;
                        });
                      } else {
                        setState(() {
                          isCopyErrorVisible = true;
                        });
                      }
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.purple),
                    ),
                    child: Text("Copy"),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Select checkbox to generate password",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.purple),
              ),
              Visibility(
                visible: isBoxErrorVisible,
                child: Text(
                  "Please make a selection of text in password",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                      value: isCharacter,
                      onChanged: (value) {
                        setState(() {
                          isCharacter = !isCharacter;
                        });
                      }),
                  Text(
                    "Alphabets",
                    style: TextStyle(color: Colors.purpleAccent),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      value: isSpecialCharacters,
                      onChanged: (value) {
                        setState(() {
                          isSpecialCharacters = !isSpecialCharacters;
                        });
                      }),
                  Text("Special Characters",
                      style: TextStyle(color: Colors.purpleAccent)),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      value: isNumbers,
                      onChanged: (value) {
                        setState(() {
                          isNumbers = !isNumbers;
                        });
                      }),
                  Text("Digits", style: TextStyle(color: Colors.purpleAccent)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Password Length: ",
                      style: TextStyle(color: Colors.purpleAccent)),
                  Text("$length",
                      style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 30),
                  activeTrackColor: Colors.purple,
                  thumbColor: Colors.purpleAccent,
                  // overlayColor: Color(0x29EB1555),
                  inactiveTrackColor: Color(0xFF8D8E98),
                  inactiveTickMarkColor: Color(0xFF8D8E98),
                  activeTickMarkColor: Colors.pink,
                ),
                child: Slider(
                  value: length.toDouble(),
                  divisions: 50,
                  max: 50.0,
                  onChanged: (newValue) {
                    setState(() {
                      length = newValue.toInt();
                    });
                    // print(length);
                  },
                  label: length.round().toString(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
