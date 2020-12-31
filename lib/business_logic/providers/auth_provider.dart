import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterLunchApp/business_logic/models/user.dart';

class AuthProvider with ChangeNotifier {
  List<UserModel> _users = [];
  List<UserModel> get users {
    return [..._users];
  }

  //Firebase Auth object
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

//Create user object based on the given FirebaseUser
  UserModel _userFromFirebase(User user) {
    try {
      if (user == null) {
        return null;
      }
      final newUser = UserModel(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        photoUrl: user.photoURL,
        tag: 'present',
      );
      _users.add(newUser);
      notifyListeners();
      return newUser;
    } catch (e) {
      print("Error on the new user registration = " + e.toString());
      notifyListeners();
      return null;
    }
  }

  Future<UserModel> registerWithEmailAndPassword(String email, String password,
      String displayName, File image, context) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final ref = FirebaseStorage.instance
          .ref()
          .child('Users_images')
          .child(result.user.uid + '.jpg');
      await ref.putFile(image).whenComplete(() {
        print(image);
      });
      final url = await ref.getDownloadURL();
      await _firestore.collection('users').doc(result.user.uid).set({
        'uid': result.user.uid,
        'email': email,
        'displayName': displayName,
        'photoUrl': url,
        'tag': "present",
        'createdAt': Timestamp.now(),
      });
      return _userFromFirebase(result.user);
    } catch (e) {
      print("Error on the new user registration = " + e.toString());

      notifyListeners();
      return null;
    }
  }

  //Method to handle user sign in using email and password
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      notifyListeners();
      return true;
    } catch (e) {
      print("Error on the sign in = " + e.toString());
      notifyListeners();
      return false;
    }
  }

  Future<void> updateUser(String displayName, String email, File image) async {
    final User user = _auth.currentUser;
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('Users_images')
          .child(user.uid + '.jpg');
      await ref.putFile(image).whenComplete(() {
        print(image);
      });
      final url = await ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
          {'displayName': displayName, 'email': email, 'photoUrl': url});
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    _auth.signOut();

    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> getData() async {
    FirebaseFirestore.instance.collection('users').doc().snapshots();
    notifyListeners();
  }
}
