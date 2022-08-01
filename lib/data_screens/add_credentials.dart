import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:password_manager/models/database.dart';
import 'package:provider/provider.dart';

class AddCredentials extends StatefulWidget {
  // final Function addtx;
  // NewTransactions(this.addtx);

  @override
  State<AddCredentials> createState() => _AddCredentialsState();
}

class _AddCredentialsState extends State<AddCredentials> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final websiteController = TextEditingController();

  void randomCharString(int length, String text) {
    Random _random = Random();

    final randomString =
    List.generate(length, (index) => text[_random.nextInt(text.length)])
        .join();
    setState(() {
      passwordController.text = randomString;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<Credentials>(builder: (context, Credential, child) {
      return SingleChildScrollView(
        child: Container(
          color: Color(0xFF757575),
          child: Container(
            padding: EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Username',
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple)),
                        labelStyle: TextStyle(color: Colors.purpleAccent)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "username is required";
                      }
                    },
                    controller: usernameController,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is required";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.purpleAccent),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                    ),
                    controller: emailController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Password',
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple)),
                        labelStyle: TextStyle(color: Colors.purpleAccent)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password is required";
                      }
                    },
                    controller: passwordController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Website/App',
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple)),
                        labelStyle: TextStyle(color: Colors.purpleAccent)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Website is required";
                      }
                    },
                    controller: websiteController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Credential.postDetailsToFireStore(emailController.text,
                                  usernameController.text, websiteController.text,passwordController.text);
                              Navigator.of(context).pop();
                              Credential.getList();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple,
                            ),
                            child: Text(
                              "Add Credentials",
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 30,),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              randomCharString(8, "!@#\\\$%^&*()_+/.,`AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890");
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple,
                            ),
                            child: Text(
                              "Generate Password",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
