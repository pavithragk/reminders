import 'package:flutter/material.dart';
import 'package:flutterLunchApp/views/widgets/total_users.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home-screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightGreen[200], body: TotalUsers());
  }
}
