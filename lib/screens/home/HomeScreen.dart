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
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.5,
          padding: EdgeInsets.only(top: 25, bottom: 30),
          margin: EdgeInsets.only(top: 40, left: 20, right: 20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  offset: Offset(1, 2),
                  spreadRadius: 1.0,
                  blurRadius: 5.0)
            ],
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),

          child:Column(
            children: <Widget>[
              new Center(
                child: new Image.asset(
                  'assets/logo.png',
                  width: 200,
                  height: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RichText(
                  // RichText is used to styling a particular text span in a text by grouping them in one widget
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                    text: 'First Challenge \n   Completed',



                  )
                )
              )
            ],
          ),
      ),
    );
  }
}
