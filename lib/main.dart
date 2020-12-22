import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterLunchApp/business_logic/models/user.dart';
import 'package:flutterLunchApp/business_logic/providers/auth_provider.dart';
import 'package:flutterLunchApp/views/screens/auth_screen.dart';
import 'package:flutterLunchApp/views/screens/bottom_navigation_screen.dart';
import 'package:flutterLunchApp/views/screens/home_screen.dart';
import 'package:flutterLunchApp/views/screens/reminder_screen.dart';
import 'package:flutterLunchApp/views/screens/reminder_screen.dart';
import 'package:flutterLunchApp/views/widgets/user_info.dart';
import 'package:flutterLunchApp/views/widgets/user_profile_input.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
        create: (context) => AuthProvider(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme:
              ThemeData(primarySwatch: Colors.red, accentColor: Colors.black),
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (ctx, userSnapshot) {
                if (userSnapshot.hasData) {
                  return BottomNavigationScreen();
                }
                return AuthScreen();
                // return ReminderScreen();
              }),
          // home: AuthScreen(),
          routes: {
            BottomNavigationScreen.routeName: (ctx) => BottomNavigationScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            UserProfileInput.routeName: (ctx) => UserProfileInput(),
            ReminderScreen.routeName: (ctx) => ReminderScreen(),
          },
        ));
    // return MaterialApp(home: UserInfoScreen());
  }
}
