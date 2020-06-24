
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterauthentication/model/user.dart';
import 'package:flutterauthentication/screens/authenticate/authenticate.dart';
import 'package:flutterauthentication/screens/home/HomeScreen.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
//if user not login then Authenticate else HomeScreen
    if(user == null)
      return Authenticate();
    else
      return HomeScreen();
  }
}
