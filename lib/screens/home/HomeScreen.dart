import 'package:flutter/material.dart';
import 'package:flutterauthentication/screens/home/NavDrawer.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //sidemenu
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xffFBB034),
      ),
    );
  }
}
