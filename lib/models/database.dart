import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

final _fireStore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User? user = _auth.currentUser;

class Credentials with ChangeNotifier {
  String? email;
  String? userName;
  String? password;
  String? website;

  Credentials({this.userName, this.password, this.website, this.email});

  // List<Credentials> credentialsList = [];

  factory Credentials.fromMap(map) {
    return Credentials(
        email: map['email'],
        userName: map['userName'],
        password: map['password'],
        website: map['website']);
  }

  //sending data to firebase
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'website': website,
      'userName': userName,
    };
  }

  postDetailsToFireStore(
      String email, String name, String website, String password) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    Credentials credentials = Credentials();
    credentials.userName = name;
    credentials.password = password;
    credentials.website = website;
    credentials.email = email;

    await firebaseFirestore
        .collection('Users')
        .doc(user?.uid)
        .collection('credentials')
        .doc()
        .set(credentials.toMap());
    Fluttertoast.showToast(msg: "Credentials Added Successfully");
    notifyListeners();
  }

  void delete(DocumentSnapshot data) {
    _fireStore
        .collection('Users')
        .doc(user!.uid)
        .collection('credentials')
        .doc(data.id)
        .delete();
    notifyListeners();
  }

  void update(String email, String name, String website, String password,
      DocumentSnapshot data) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    Credentials credentials = Credentials();
    credentials.userName = name;
    credentials.password = password;
    credentials.website = website;
    credentials.email = email;
    firebaseFirestore
        .collection('Users')
        .doc(user!.uid)
        .collection('credentials')
        .doc(data.id)
        .update(credentials.toMap());
    notifyListeners();
  }

  List<Credentials> sampleList = [];

  getList() async {
    await _fireStore
        .collection('Users')
        .doc(user!.uid)
        .collection('credentials')
        .snapshots()
        .listen((snap) {
      sampleList.clear();
      snap.docs.forEach((d) {
        sampleList.add(
          Credentials(
              password: d.get('password'),
              website: d.get('website'),
              userName: d.get('userName'),
              email: d.get('email')),
        );
      });
    });
  }

  void clearIt() {
    sampleList.clear();
  }
}
