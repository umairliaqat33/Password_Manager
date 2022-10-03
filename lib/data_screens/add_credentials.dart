import 'dart:math';

import 'package:flutter/material.dart';
import 'package:password_manager/models/database.dart';
import 'package:provider/provider.dart';

class AddCredentials extends StatefulWidget {
  @override
  State<AddCredentials> createState() => _AddCredentialsState();
}

class _AddCredentialsState extends State<AddCredentials> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final websiteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        title: Text("Add Credentials"),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                    return null;
                  },
                  controller: usernameController,
                ),
                TextFormField(
                  validator: (value) {
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value!)) {
                      return "Enter a valid email";
                    }
                    if (value.isEmpty) {
                      return "Email is required";
                    }
                    return null;
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
                    RegExp regex = new RegExp(r"^.{16,}$");
                    if (value!.isEmpty) {
                      return "Password is required";
                    }
                    if (!regex.hasMatch(value)) {
                      return "Password must contain 16 characters minimum";
                    }
                    return null;
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
                    return null;
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
                            randomCharString(16,
                                "!@#\\\$%^&*()_+/.,`AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                          ),
                          child: Text(
                            "Generate Password",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Credential.postDetailsToFireStore(
                                  emailController.text,
                                  usernameController.text,
                                  websiteController.text,
                                  passwordController.text);
                              Navigator.of(context).pop();
                              Credential.getList();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                          ),
                          child: Text(
                            "Add Credentials",
                            style: TextStyle(
                              fontSize: 13,
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
      );
    });
  }
}
