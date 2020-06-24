import 'package:flutter/material.dart';
import 'package:flutterauthentication/screens/authenticate/LoginScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutterauthentication/screens/authenticate/signup.dart';
import 'package:flutterauthentication/screens/authenticate/PhoneNumberLogin.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  bool showLogin = true;

  //toggle beetween login and singUp
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  //toggle beetween phoneNumberLogin and EmailandPass
  void toggleScreen() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn == true) {
      if (showLogin == true) {
        return LoginScreen(
          toggleView: toggleView,
          toggleScreen: toggleScreen,
        );
      } else {
        return PhoneNumberLogin(
          toggleView: toggleView,
          toggleScreen: toggleScreen,
        );
      }
    } else
      return SignUp(
        toggleView: toggleView,
        toggleScreen: toggleScreen,
      );
  }
}
