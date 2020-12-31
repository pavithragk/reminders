import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterLunchApp/business_logic/providers/auth_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserProfileInput extends StatefulWidget {
  static const routeName = 'user-profile';

  @override
  _UserProfileInputState createState() => _UserProfileInputState();
}

class _UserProfileInputState extends State<UserProfileInput> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String image;

  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _emailEditingController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void upDate() async {
    final updateUser = Provider.of<AuthProvider>(context, listen: false);
    updateUser.updateUser(
        _nameEditingController.text, _emailEditingController.text, pickedImage);
  }

  File pickedImage;
  var pickImage = ImagePicker();

  void _pickedImage() async {
    final PickedFile pickedFile = await pickImage.getImage(
        source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    setState(() {
      pickedImage = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = _auth.currentUser;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).accentColor,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .snapshots(),
          // ignore: missing_return
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            var userDoc = snapshot.data;

            _nameEditingController.text = userDoc["displayName"];
            _emailEditingController.text = userDoc["email"];
            image = userDoc["photoUrl"];

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: pickedImage != null
                          ? FileImage(pickedImage)
                          : NetworkImage(image),
                    ),
                    FlatButton.icon(
                        onPressed: _pickedImage,
                        icon: Icon(
                          Icons.photo,
                          color: Theme.of(context).primaryColor,
                        ),
                        label: Text("change profile",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor))),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1)),
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: InputBorder.none,
                          ),
                          controller: _nameEditingController,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).primaryColor, width: 1)),
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: InputBorder.none,
                        ),
                        controller: _emailEditingController,
                        style: TextStyle(color: Theme.of(context).primaryColor),
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
                              color: Theme.of(context).primaryColor,
                              onPressed: upDate,
                              child: Text(
                                'Save',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            RaisedButton(
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                              },
                              child: Text(
                                'Logout',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
