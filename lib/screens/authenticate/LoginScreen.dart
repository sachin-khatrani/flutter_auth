import 'package:flutter/material.dart';
import 'package:flutterauthentication/screens/authenticate/ForgotPasswordScreen.dart';
import 'package:flutterauthentication/screens/authenticate/PhoneNumberLogin.dart';
import 'package:flutterauthentication/screens/home/HomeScreen.dart';
import 'package:flutterauthentication/services/authentication.dart';
import '../../Shared/clipper.dart';
import '../../Shared/widgets.dart';

class LoginScreen extends StatefulWidget {
  final Function toggleView;
  final Function toggleScreen;
  LoginScreen({Key key, this.toggleView, this.toggleScreen}) : super(key: key);

  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              // Adding Linear Gradient to the background of UI
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                // Colors are converted to Integer from Hex Codes by replacing # with 0xff
                colors: [Color(0xffFBB034), Color(0xffb4d124)],
              ),
            ),
            child: Column(
              children: <Widget>[
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  // elevation removes the shadow under the action bar
                  title: Text(
                    "LOGIN",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true,
                  leading: Icon(Icons.arrow_back),

                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/logo.png'),
                    )
                  ],
                ),
                ClipPath(
                  clipper: BottomClipper(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 10, bottom: 30),
                    margin: EdgeInsets.only(top: 30, left: 20, right: 20),
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
                    child: Column(
                      children: <Widget>[
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: MyTextFormField(
                                  icon: Icon(Icons.email),
                                  hintText: 'Email',
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Enter your Email';
                                    }
                                    return null;
                                  },
                                  isEmail: true,
                                  onSaved: (String value) {
                                    email = value;
                                  },
                                ),
                              ),
                              Container(
                                child: MyTextFormField(
                                  icon: Icon(Icons.email),
                                  hintText: 'Password',
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Enter your Password';
                                    }
                                    return null;
                                  },
                                  isPassword: true,
                                  onSaved: (String value) {
                                    password = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text('${error}'),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 18),
                            child: InkWell(
                              child: Text(
                                'Forgot Password',
                                style: TextStyle(
                                  color: Color(0xffFBB034),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPasswordScreen()));
                              },
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: InkWell(
                            onTap: () async {
                              widget.toggleScreen();
                            },
                            child: RichText(
                              // RichText is used to styling a particular text span in a text by grouping them in one widget
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                text: 'Login using ',
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Mobile Number and OTP',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            InkWell(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  dynamic result = await AuthService()
                                      .signInWithEmailAndPassword(
                                          email, password);

                                  if (result == null) {
                                    setState(() {
                                      error =
                                          'could not sign with this credensials';
                                      // loading = false;
                                    });
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen()));
                                  }
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                margin: EdgeInsets.only(right: 20, top: 10),
                                decoration: BoxDecoration(
                                  color: Color(0xffFBB034),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Icon(
                                  Icons.navigate_next,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                ClipPath(
                  clipper: TopClipper(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 30, bottom: 30),
                    margin: EdgeInsets.only(left: 20, right: 20),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Or",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff898989),
                          ),
                        ),
                        Text(
                          "Login with Social Media",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff898989),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new RaisedButton(
                                elevation: 0.0,
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0)),
                                padding: EdgeInsets.only(
                                    top: 7.0,
                                    bottom: 7.0,
                                    right: 40.0,
                                    left: 15.0),
                                onPressed: () async {
                                  var res = await AuthService()
                                      .initiateFacebookLogin();
                                  if (res == false) {
                                    _showSnackBar(
                                        'Not Login Using Facebook', context);
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen()));
                                  }
                                },
                                child: Image.asset(
                                  'assets/fb_icon.png',
                                  height: 40.0,
                                  width: 40.0,
                                ),
                                textColor: Color(0xFF292929),
                                color: Colors.white),
                            new RaisedButton(
                                elevation: 0.0,
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0)),
                                padding: EdgeInsets.only(
                                    top: 7.0,
                                    bottom: 7.0,
                                    right: 30.0,
                                    left: 7.0),
                                onPressed: () {
                                  //var user =  AuthService().handleSignIn();
                                  //print(user);
                                  // Navigator.of(context).pushReplacementNamed(VIDEO_SPALSH);
                                },
                                child: Image.asset(
                                  'assets/g_plus_icon.png',
                                  height: 40.0,
                                  width: 40.0,
                                ),
                                textColor: Color(0xFF292929),
                                color: Colors.white),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () async {
                      widget.toggleView();
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Click here to signup",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showSnackBar(String text, BuildContext context) {
    final snackBar = SnackBar(
      content: Text('$text'),
      duration: Duration(seconds: 2),
    );
  }
}
