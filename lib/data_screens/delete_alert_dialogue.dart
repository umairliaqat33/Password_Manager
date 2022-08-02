import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:password_manager/models/database.dart';

creatingDeleteAlertDialog(BuildContext context, DocumentSnapshot data) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          title: Text('Delete Credentials'),
          content: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(fontSize: 20, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: data.get('website'),
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                  TextSpan(
                      text: "\'s credentials",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                  TextSpan(
                      text: "\nAre you sure you want to delete?",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      )),
                  TextSpan(
                      text: "\n*Once deleted will never be restored*",
                      style: TextStyle(fontSize: 10, color: Colors.red))
                ],
              )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Fluttertoast.showToast(
                    msg: "Credentials deleted", fontSize: 16.0);
                Credentials credential = Credentials();
                credential.delete(data);
              },
              child: Text(
                "Delete",
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
