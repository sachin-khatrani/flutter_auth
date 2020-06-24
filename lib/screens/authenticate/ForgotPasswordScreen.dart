import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterauthentication/Shared/widgets.dart';
import 'package:flutterauthentication/services/authentication.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  "Forgot Password",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/logo.png'),
                  )
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 40, bottom: 30),
                margin: EdgeInsets.only(top: 70, left: 20, right: 20),
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
                      new InkWell(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();

                            AuthService().resetPassword(email);
                          }
                        },
                        child: new Container(
                          width: 150.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                            color: Color(0xffFBB034),
                            border:
                                new Border.all(color: Colors.white, width: 2.0),
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          margin: EdgeInsets.only(top: 110, bottom: 35),
                          child: new Center(
                            child: new Text(
                              'Proceed',
                              style: new TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
