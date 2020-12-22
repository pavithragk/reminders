import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterLunchApp/business_logic/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class UserProfileInput extends StatefulWidget {
  static const routeName = 'user-profile';

  @override
  _UserProfileInputState createState() => _UserProfileInputState();
}

class _UserProfileInputState extends State<UserProfileInput> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _emailEditingController = TextEditingController();

  void upDate() async {
    final User user = _auth.currentUser;
    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'displayName': _nameEditingController.text,
      'email': _emailEditingController.text,
    });
  }

  @override
  void didChangeDependencies() {
    final User user = _auth.currentUser;
    final userData = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((value) {
      final String _userName = value.data()['displayName'];
      final String _email = value.data()['email'];
      _nameEditingController.text = _userName;
      _emailEditingController.text = _email;
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[200],
      body: Padding(
        padding: const EdgeInsets.only(
          top: 100,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1)),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        border: InputBorder.none,
                      ),
                      controller: _nameEditingController,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)),
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      border: InputBorder.none,
                    ),
                    controller: _emailEditingController,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Row(
                      children: [
                        RaisedButton(
                          color: Theme.of(context).accentColor,
                          onPressed: upDate,
                          child: Text(
                            'Save',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        RaisedButton(
                          color: Theme.of(context).accentColor,
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                          },
                          child: Text(
                            'Logout',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
