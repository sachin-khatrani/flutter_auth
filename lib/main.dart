import 'package:flutter/material.dart';
import 'package:flutterauthentication/model/user.dart';
import 'package:flutterauthentication/services/authentication.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'screens/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        // debugShowCheckedModeBanner is set to false so that the debug badge from UI is removed
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
          '/Wrapper': (BuildContext context) => new Wrapper()
        }, // HomeScreen is the landing page of the app
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Wrapper()));

  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffFBB034), Color(0xffb4d124)])),
        child: new Center(
          child: new Image.asset(
            'assets/logo.png',
            width: 310,
            height: 310,
          ),
        ),
      ),
    );
  }
}
