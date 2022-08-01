import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/models/database.dart';
import 'package:provider/provider.dart';

final _fireStore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User? user = _auth.currentUser;

class PasswordList extends StatefulWidget {
  const PasswordList({Key? key}) : super(key: key);

  @override
  State<PasswordList> createState() => _PasswordListState();
}

class _PasswordListState extends State<PasswordList> {
  @override
  void initState() {
    setState(() {
      Credentials transact = Credentials();
      transact.getList();
      // transact.recentTransactions;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Credentials>(
      builder: (context, Password, child) {
        return StreamBuilder<QuerySnapshot>(
          stream: _fireStore
              .collection('Users')
              .doc(user!.uid)
              .collection('credentials')
              // .orderBy('website', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            final media = MediaQuery.of(context);
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  ))
                : snapshot.data!.docs.isEmpty
                    ? Column(
                        children: [
                          Text(
                            "No transaction yet!",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 200,
                            child: Image.asset(
                              "image/waiting.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data!.docs[index];
                          String name = data.get("userName");
                          String password = data.get("password");
                          String email=data.get("email");
                          String website=data.get("website");
                          return Card(
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
                                    //it will help our text not to occupy space which is remaining after all other widgets.
                                    fit: FlexFit.tight,
                                    child: SingleChildScrollView(
                                      //this is used to make our text scrollable if text exceeds from limit
                                      scrollDirection: Axis.horizontal,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                  Container(
                                      child: Align(
                                    alignment: Alignment.centerRight,
                                    child: media.size.width > 450
                                        ? TextButton.icon(
                                            onPressed: () {

                                            },
                                            icon: Icon(Icons.delete),
                                            label: Text("Delete"),
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              Password.delete(data);
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
                            ),
                          );
                        });
          },
        );
      },
    );
  }
}
