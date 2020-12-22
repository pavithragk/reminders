import 'package:flutter/material.dart';
import 'package:flutterLunchApp/views/widgets/user_profile_input.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return UserProfileInput();
  }
}
