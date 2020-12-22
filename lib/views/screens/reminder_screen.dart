import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterLunchApp/business_logic/providers/auth_provider.dart';
import 'package:flutterLunchApp/views/screens/bottom_navigation_screen.dart';
import 'package:flutterLunchApp/views/screens/home_screen.dart';
import 'package:provider/provider.dart';

// import 'dart:html';
class Arguments {
  final String email;
  final String password;
  final String userName;
  bool isLogin;
  Arguments({this.email, this.password, this.userName, this.isLogin});
}

class ReminderScreen extends StatefulWidget {
  static const routeName = '/reminder';

  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  TextEditingController _controller = TextEditingController();
  GlobalKey<FormState> _formKey = new GlobalKey();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var reminder = "";
    final Arguments nameArgs = ModalRoute.of(context).settings.arguments;
    print(nameArgs.email);
    var _value = 1;
    var selectedTime = 1;
    Future<void> setReminder() async {
      reminder = _controller.text;
      _formKey.currentState.save();
      final _authProvider = Provider.of<AuthProvider>(context, listen: false);
      try {
        await _authProvider.registerWithEmailAndPassword(
          nameArgs.email,
          nameArgs.password,
          nameArgs.userName,
          reminder,
          _value,
          selectedTime,
        );
      } catch (e) {
        print(e.toString());
      }
    }

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white30,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
            ),
            width: double.infinity,
            height: 300,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Card(
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Text(
                      "Reminder!!",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
                    ),
                  ),
                  elevation: 10),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
              child: Text(
            "Press + to add a reminder",
            style: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.bold,
                fontSize: 30),
          )),
        ],
      ),
      floatingActionButton: showFab
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.add, color: Theme.of(context).accentColor),
              onPressed: () {
                var bottomSheetController =
                    scaffoldKey.currentState.showBottomSheet(
                  (context) => Container(
                    width: double.infinity,
                    height: 400,
                    color: Colors.grey,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.all(Radius.circular(10)),
                    // )
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30, left: 10.0),
                          child: Text(
                            "what's the reminder?",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: _formKey,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Reminder",
                              ),
                              controller: _controller,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "select time for morning breakfast!!",
                                style: TextStyle(fontSize: 20.0),
                              ),
                              SizedBox(width: 20),
                              DropdownButton(
                                  value: _value,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("8am"),
                                      value: 1,
                                    ),
                                    DropdownMenuItem(
                                      child: Text("10pm"),
                                      value: 2,
                                    )
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value;
                                    });
                                  }),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Repeat",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 150),
                              child: DropdownButton(
                                  value: selectedTime,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("daily"),
                                      value: 1,
                                    ),
                                    DropdownMenuItem(
                                      child: Text("weekly"),
                                      value: 2,
                                    )
                                  ],
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedTime = newValue;
                                    });
                                  }),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30, left: 50),
                          child: Row(
                            children: [
                              RaisedButton(
                                color: Colors.grey,
                                onPressed: () {},
                                child: Text("cancel"),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              RaisedButton(
                                color: Colors.grey,
                                onPressed: setReminder,
                                child: Text("save"),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
                showFloatingActionButton(false);
                bottomSheetController.closed.then((value) {
                  showFloatingActionButton(true);
                });
              },
            )
          : Container(),
    );
  }

  bool showFab = true;
  void showFloatingActionButton(bool value) {
    setState(() {
      showFab = value;
    });
  }
}
