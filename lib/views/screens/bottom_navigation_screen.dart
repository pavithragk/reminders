import 'package:flutter/material.dart';
import 'package:flutterLunchApp/views/screens/home_screen.dart';
import 'package:flutterLunchApp/views/screens/user_profile.dart';

class BottomNavigationScreen extends StatefulWidget {
  static const routeName = 'bottom-navigation';
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageindex = 0;

  @override
  void initState() {
    _pages = [
      {'page': HomeScreen(), 'title': "it's lunch time!!"},
      {
        'page': UserProfile(),
        'title': 'Profile',
      }
    ];

    super.initState();
  }

  void selectedPage(int index) {
    setState(() {
      _selectedPageindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedPageindex]['title']),
        ),
        body: _pages[_selectedPageindex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          unselectedLabelStyle: TextStyle(color: Theme.of(context).accentColor),
          backgroundColor: Theme.of(context).primaryColor,
          onTap: selectedPage,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Theme.of(context).accentColor),
                label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box,
                    color: Theme.of(context).accentColor),
                label: 'profile'),
          ],
          currentIndex: _selectedPageindex,
        ));
  }
}
