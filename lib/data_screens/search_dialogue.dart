import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/data_screens/view_dialogue.dart';
import 'package:password_manager/screens/screen_shifter.dart';
import 'package:provider/provider.dart';

import '../models/database.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String name = "";
  final _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Consumer<Credentials>(builder: (context, Transactions, child) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () async {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Shifter()));
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Card(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search), hintText: 'Search...'),
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              },
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _fireStore
              .collection('Users')
              .doc(user!.uid)
              .collection('credentials')
              .snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;
                      if (data['userName']
                          .toString()
                          .toLowerCase()
                          .startsWith(name.toLowerCase())) {
                        return GestureDetector(
                          onTap: () {
                            createDialogBox(
                                context,
                                data['email'],
                                data['name'],
                                data['password'],
                                data['website']);
                          },
                          child: ListTile(
                            title: Text(
                              data['userName'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              data['email'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      }
                      return Container();
                    });
          },
        ),
      );
    });
  }
}
