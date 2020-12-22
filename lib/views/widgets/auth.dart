import 'package:flutter/material.dart';
import 'package:flutterLunchApp/business_logic/providers/auth_provider.dart';
import 'package:flutterLunchApp/views/screens/reminder_screen.dart';
import 'package:provider/provider.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  GlobalKey<FormState> _formKey = new GlobalKey();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isLogin = true;
  var email = '';
  var password = '';
  var displayName = '';

  @override
  Widget build(BuildContext context) {
    Future<void> _trySubmit() async {
      email = _emailController.text;
      password = _passwordController.text;
      displayName = _userNameController.text;

      if (!_formKey.currentState.validate()) {
        // Invalid!
        return null;
      }
      _formKey.currentState.save();
      final _authProvider = Provider.of<AuthProvider>(context, listen: false);
      try {
        if (_isLogin) {
          await _authProvider.signInWithEmailAndPassword(email, password);
        } else {
          Navigator.pushNamed(context, ReminderScreen.routeName,
              arguments: Arguments(
                  email: email,
                  password: password,
                  userName: displayName,
                  isLogin: _isLogin));
        }
      } catch (e) {
        print(e.toString());
      }
    }
    //   _formKey.currentState.save();
    //
    // Future<void> _trySubmit() async {
    //   email = _emailController.text;
    //   password = _passwordController.text;
    //   displayName = _userNameController.text;
    //   if (!_formKey.currentState.validate()) {
    //     // Invalid!
    //     return null;
    //   }
    //   _formKey.currentState.save();
    //   final _authProvider = Provider.of<AuthProvider>(context, listen: false);
    //   try {
    //     if (_isLogin) {
    //       await _authProvider.signInWithEmailAndPassword(email, password);
    //     } else {
    //       await _authProvider.registerWithEmailAndPassword(
    //           email, password, displayName);
    //     }
    //   } catch (e) {
    //     print(e.toString());
    //   }
    // }

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 250),
              child: Column(
                children: [
                  _isLogin
                      ? Icon(
                          Icons.restaurant,
                          size: 50,
                          color: Colors.white,
                        )
                      : CircleAvatar(
                          radius: 40,
                        ),
                  _isLogin ? SizedBox(height: 30.0) : Container(),
                  // if (!_islogin) UserImagePicker(_pickedImage),
                  !_isLogin
                      ? FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.camera),
                          label: Text('take picture here!'),
                        )
                      : Container(),
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6.0,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                controller: _emailController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.purple[200],
                                  ),
                                  hintText: 'Enter your Email',
                                  border: InputBorder.none,
                                  labelText: 'email',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "password cannot be empty";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6.0,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: !_isLogin
                                  ? TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.account_box,
                                          color: Colors.purple[200],
                                        ),
                                        hintText: 'Enter your name',
                                        border: InputBorder.none,
                                        labelText: 'username',
                                      ),
                                      controller: _userNameController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'username cannot be empty';
                                        }
                                        return null;
                                      },
                                    )
                                  : null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6.0,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: _passwordController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.purple[200],
                                  ),
                                  hintText: 'Enter your password',
                                  border: InputBorder.none,
                                  labelText: 'password',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'password can not be empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          RaisedButton(
                            color: Theme.of(context).accentColor,
                            onPressed: _trySubmit,
                            child: Text(
                              // _isLogin ? 'login' : 'SignUp',
                              _isLogin ? 'login' : 'next',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(
                      _isLogin
                          ? 'No account Sign up here'
                          : 'I already have an account!',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
