import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:password_manager/models/database.dart';

createUpdateDialogBox(BuildContext context, String email, String username,
    String password, String website, String id) {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final websiteController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
          title: Text("Update Credentials"),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
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
                      onChanged: (value) {
                        emailController.text = value;
                      },
                      controller: emailController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.purpleAccent),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple)),
                      ),
                      onChanged: (value) {
                        usernameController.text = value;
                      },
                      controller: usernameController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.purpleAccent),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple)),
                      ),
                      onChanged: (value) {
                        passwordController.text = value;
                      },
                      controller: passwordController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Website/App',
                        labelStyle: TextStyle(color: Colors.purpleAccent),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple)),
                      ),
                      onChanged: (value) {
                        websiteController.text = value;
                      },
                      controller: websiteController,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  try {
                    Credentials credential = Credentials();
                    credential.update(
                        emailController.text,
                        usernameController.text,
                        websiteController.text,
                        passwordController.text,
                        id);
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                        msg: "Credentials Updated", fontSize: 16.0);
                    // credential.delete(data);
                  } catch (e) {
                    Fluttertoast.showToast(msg: e.toString(), fontSize: 16.0);
                  }
                }
              },
              child: Text(
                "Update",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        );
      });
}
