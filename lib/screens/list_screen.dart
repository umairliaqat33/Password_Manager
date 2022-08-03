import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/data_screens/delete_alert_dialogue.dart';
import 'package:password_manager/data_screens/update_dialogue.dart';
import 'package:password_manager/data_screens/view_dialogue.dart';

import '../data_screens/delete_alert_dialogue.dart';

class PasswordList extends StatefulWidget {
  const PasswordList({Key? key}) : super(key: key);

  @override
  State<PasswordList> createState() => _PasswordListState();
}

class _PasswordListState extends State<PasswordList> {
  final _fireStore = FirebaseFirestore.instance;
  User? user;
  @override
  void initState() {
    super.initState();
    final _auth = FirebaseAuth.instance;
    user = _auth.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore
          .collection('Users')
          .doc(user!.uid)
          .collection('credentials')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        final media = MediaQuery.of(context);

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          );
        }

        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data == null) {
            return const SizedBox();
          }
          if (data.docs.isEmpty) {
            return Column(
              children: [
                Text(
                  "No transaction yet!",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  child: Image.asset(
                    "image/waiting.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot data = snapshot.data!.docs[index];
                String name = data.get("userName");
                String password = data.get("password");
                String email = data.get("email");
                String website = data.get("website");
                return GestureDetector(
                  onTap: () {
                    createDialogBox(context, email, name, password, website);
                  },
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            padding: EdgeInsets.all(5),
                            child: CircleAvatar(
                              radius: 30,
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: FittedBox(
                                  child: Text(
                                    website,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    email,
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                  child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () {
                                    createUpdateDialogBox(context, email, name,
                                        password, website, data.id);

                                    print("password updated");
                                  },
                                  icon: Icon(
                                    Icons.edit_note,
                                    color: Colors.purpleAccent,
                                  ),
                                ),
                              )),
                              Container(
                                  child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () {
                                    creatingDeleteAlertDialog(context, data);
                                    print("password deleted");
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.purpleAccent,
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        } else {
          return Text('No Data');
        }
      },
    );
  }
}
