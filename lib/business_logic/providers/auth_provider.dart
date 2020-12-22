import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  // Method for new user registration using email and password
  Future<UserModel> registerWithEmailAndPassword(
      String email,
      String password,
      String displayName,
      String reminder,
      int setTime,
      int selectedValue) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _firestore.collection('users').doc(result.user.uid).set({
        'uid': result.user.uid,
        'email': email,
        'displayName': displayName,
        'photoUrl': result.user.photoURL,
        'tag': "present",
        'createdAt': Timestamp.now(),
      }).then((value) async {
        await _firestore
            .collection('users')
            .doc(result.user.uid)
            .collection('reminders')
            .doc(result.user.uid)
            .set({
          'remindertext': reminder,
          'setTime': setTime,
          'selectedValue': selectedValue,
        });
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

  Future updateName(String displayName, String email) {
    _auth.currentUser;
  }

  Future signOut() async {
    _auth.signOut();

    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  // void getData() {
  //   var userName = '';
  //   var tag = '';
  //   final User user = _auth.currentUser;
  //   _firestore.collection("users").doc(user.uid).get().then((value) {
  //     userName = value.data()["displayName"];
  //     tag = value.data()["tag"];
  //     notifyListeners();
  //   });
  // }
}
