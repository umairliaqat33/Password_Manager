import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:password_manager/models/database.dart';

createDialogBox(BuildContext context, String email, String username,
    String password, String website) {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final websiteController = TextEditingController();
  final passwordController = TextEditingController();
  bool isCopyErrorVisible = false;

  return showDialog(
      context: context,
      builder: (context) {
        emailController.text = email;
        usernameController.text = username;
        passwordController.text = password;
        websiteController.text = website;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          title: Text("View Credentials"),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Visibility(
                    visible: isCopyErrorVisible,
                    child: Text(
                      "Something went wrong try again",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            if (!emailController.text.isEmpty) {
                              Clipboard.setData(
                                  ClipboardData(text: emailController.text));
                              Fluttertoast.showToast(msg: "Text Copied");
                              isCopyErrorVisible = false;
                            } else {
                              isCopyErrorVisible = true;
                            }
                          },
                          icon: Icon(Icons.copy)),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.purpleAccent),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                    ),
                    controller: emailController,
                  ),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            if (!usernameController.text.isEmpty) {
                              Clipboard.setData(
                                  ClipboardData(text: usernameController.text));
                              Fluttertoast.showToast(msg: "Text Copied");
                              isCopyErrorVisible = false;
                            } else {
                              isCopyErrorVisible = true;
                            }
                          },
                          icon: Icon(Icons.copy)),
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.purpleAccent),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                    ),
                    controller: emailController,
                  ),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            if (!passwordController.text.isEmpty) {
                              Clipboard.setData(
                                  ClipboardData(text: passwordController.text));
                              Fluttertoast.showToast(msg: "Text Copied");
                              isCopyErrorVisible = false;
                            } else {
                              isCopyErrorVisible = true;
                            }
                          },
                          icon: Icon(Icons.copy)),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.purpleAccent),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                    ),
                    controller: emailController,
                  ),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (!websiteController.text.isEmpty) {
                            Clipboard.setData(
                                ClipboardData(text: websiteController.text));
                            Fluttertoast.showToast(msg: "Text Copied");
                            isCopyErrorVisible = false;
                          } else {
                            isCopyErrorVisible = true;
                          }
                        },
                        icon: Icon(Icons.copy),
                      ),
                      labelText: 'Website/App',
                      labelStyle: TextStyle(color: Colors.purpleAccent),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                    ),
                    controller: emailController,
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
