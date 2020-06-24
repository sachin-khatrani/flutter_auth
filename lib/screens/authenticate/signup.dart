import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterauthentication/model/user.dart';
import 'package:flutterauthentication/screens/authenticate/ProfileScreen.dart';
import 'package:flutterauthentication/services/authentication.dart';
import 'package:flutterauthentication/Shared/loading.dart';
import '../../Shared/widgets.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  final Function toggleScreen;
  SignUp({Key key, this.toggleView, this.toggleScreen}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //formkey for controller
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  AuthService authService = AuthService();

  //store data in object
  UserData user = UserData();
  //checkbox is checked or not
  bool isCheck = false;
  String password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user.fullName = 'Full Name';
    user.email = 'Email';
    user.phoneNumber = 'Phone Number';
    user.password = 'Password';
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
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
                          "Sign Up",
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
                      Container(
                        width: MediaQuery.of(context).size.width - 15,
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: MyTextFormField(
                                  icon: Icon(Icons.email),
                                  hintText: '${user.fullName}',
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Enter your Full name';
                                    }
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    user.fullName = value;
                                  },
                                ),
                              ),
                              Container(
                                child: MyTextFormField(
                                  icon: Icon(Icons.email),
                                  hintText: '${user.email}',
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Enter your Email';
                                    }
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    user.email = value;
                                  },
                                  isEmail: true,
                                ),
                              ),
                              Container(
                                child: MyTextFormField(
                                  icon: Icon(Icons.phone),
                                  hintText: '${user.phoneNumber}',
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Enter your Phone Number';
                                    } else if (value.length != 10) {
                                      return 'Enter Valid Number';
                                    }
                                    return null;
                                  },
                                  isPhoneNumber: true,
                                  onSaved: (String value) {
                                    user.phoneNumber = value;
                                  },
                                ),
                              ),
                              Container(
                                child: MyTextFormField(
                                  icon: Icon(Icons.lock),
                                  hintText: '${user.password}',
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Enter your Password';
                                    }
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    user.password = value;
                                  },
                                  isPassword: true,
                                ),
                              ),
                              Container(
                                child: MyTextFormField(
                                  icon: Icon(Icons.lock),
                                  hintText: 'Confirm Password',
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Enter your Confirm Password';
                                    }
                                    return null;
                                  },
                                  isPassword: true,
                                  onSaved: (String value) {
                                    password = value;
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Checkbox(
                                    value: isCheck,
                                    onChanged: (value) {
                                      setState(() {
                                        isCheck = value;
                                      });
                                    },
                                  ),
                                  RichText(
                                    // RichText is used to styling a particular text span in a text by grouping them in one widget
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      text: 'I agree to ',
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              'Terms and Condition\n and Privacy Policy',
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Color(0xffFBB034)),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () async {
                                  if (_formKey.currentState.validate()) {
                                    await _formKey.currentState.save();

                                    if (isCheck == true &&
                                        user.password == password) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfileScreen(data: user)));
                                    } else if (user.password == password) {
                                      _showSnackBar(
                                          'Please enter Correct Confirm password',
                                          context);
                                    } else if (isCheck == false) {
                                      _showSnackBar(
                                          'Please check Terms & Condition',
                                          context);
                                    }
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: new Container(
                                    width: 150.0,
                                    height: 50.0,
                                    decoration: new BoxDecoration(
                                      color: Color(0xffFBB034),
                                      border: new Border.all(
                                          color: Colors.white, width: 2.0),
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                    ),
                                    child: new Center(
                                      child: new Text(
                                        'Submit',
                                        style: new TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: InkWell(
                          onTap: () {
                            widget.toggleView();
                          },
                          child: RichText(
                            // RichText is used to styling a particular text span in a text by grouping them in one widget
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              text: 'Already have an Account?',
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Click here to login',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
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

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
