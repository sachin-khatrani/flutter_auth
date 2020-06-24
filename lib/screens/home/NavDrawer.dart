import 'package:flutter/material.dart';
import 'package:flutterauthentication/screens/wrapper.dart';
import 'package:flutterauthentication/services/authentication.dart';

class NavDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Color(0xffFBB034),
            ),
          ),

          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: ()async{
             await AuthService().signOut();
             Navigator.push(context, MaterialPageRoute(builder: (context) => Wrapper()));
            },
          ),
        ],
      ),
    );
  }
}