import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterLunchApp/business_logic/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class TotalUsers extends StatefulWidget {
  @override
  _TotalUsersState createState() => _TotalUsersState();
}

class _TotalUsersState extends State<TotalUsers> {
  @override
  Widget build(BuildContext context) {
    // final userList = Provider.of<AuthProvider>(context).users;
    // print(userList);
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, userSnapshots) {
          if (userSnapshots.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final userDocs = userSnapshots.data.docs;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => ListTile(
                      leading: CircleAvatar(),
                      title: Text(userDocs[index].data()['displayName']),
                      trailing: Text(userDocs[index].data()['tag']),
                    ),
                    itemCount: userDocs.length,
                  ),
                ),
                Container(
                  height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Total:',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '20',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
              ],
            ),
          );
        });
  }
}
