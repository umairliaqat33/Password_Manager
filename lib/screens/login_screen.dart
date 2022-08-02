import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:password_manager/models/constants.dart';
import 'package:password_manager/screens/register_screen.dart';
import 'package:password_manager/screens/welcome_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  bool _passwordVisible = true;
  bool isLoginError = false;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['Email']);
  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('image/Password_manager.png'),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  Visibility(
                    visible: isLoginError,
                    child: Text(
                      "Please check your email or password",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field required";
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                    cursorColor: Colors.purple,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    controller: emailController,
                    decoration: kMessageTextFieldDecoration.copyWith(
                      hintText: 'Enter Your Email',
                      icon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      RegExp regex = new RegExp(r"^.{8,}$");
                      if (value!.isEmpty) {
                        return "Field is required";
                      }
                      if (!regex.hasMatch(value)) {
                        return "Password must contain 8 characters minimum";
                      }
                      return null;
                    },
                    cursorColor: Colors.purple,
                    textInputAction: TextInputAction.done,
                    obscureText: _passwordVisible,
                    textAlign: TextAlign.center,
                    controller: passController,
                    decoration: kMessageTextFieldDecoration.copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      hintText: 'Enter Your Password',
                      icon: Icon(Icons.vpn_key),
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      color: Colors.purple,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      elevation: 5.0,
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            showSpinner = true;
                          });
                          singIn(emailController.text, passController.text);
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        minWidth: 200.0,
                        height: 42.0,
                        child: Text(
                          'Log In',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Don\'t have an account? '),
                      TextButton(
                        style: ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationScreen()));
                        },
                        child: Text("SignUp"),
                      ),
                    ],
                  ),
                  Container(
                    height: 35,
                    child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("image/google_logo.png"),
                          Text(
                            "oogle SignIn",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        try {
                          googleSignIn();
                        } catch (e) {
                          Fluttertoast.showToast(msg: e.toString());
                          print(e.toString());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void singIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) {
          Fluttertoast.showToast(msg: "Login Successful");
        });
        setState(() {
          isLoginError = false;
        });
        Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => WelcomeUserScreen()))
            .catchError((e) {
          Fluttertoast.showToast(msg: e);
        });
      } catch (e) {
        sleep(const Duration(seconds: 5));
        showSpinner = false;
        setState(() {
          isLoginError = true;
        });
        Fluttertoast.showToast(msg: e.toString());
      }
    } else {
      setState(() {
        isLoginError = true;
      });
      showSpinner = false;
    }
  }

  Future googleSignIn() async {
    final googleUser = await _googleSignIn.signIn();
    setState(() {
      showSpinner = true;
    });
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    setState(() {
      showSpinner = false;
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => WelcomeUserScreen()));
  }
}
