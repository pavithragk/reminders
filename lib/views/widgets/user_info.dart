import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfoScreen extends StatefulWidget {
  final String id;
  final String name;
  String image;
  final String tag;
  UserInfoScreen({
    this.id,
    this.name,
    this.image,
    this.tag,
  });

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  String _name = '';
  String _tag = '';
  File _image;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FlatButton(
              onPressed: () {
                final User user = _auth.currentUser;
                _name = user.displayName;
                print(user.displayName);
              },
              child: Text("text")),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                  // backgroundImage: NetworkImage(_image)
                  ),
              title: Text(
                // _name,
                "first",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              trailing: Text(
                // _tag,
                "test2",
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
