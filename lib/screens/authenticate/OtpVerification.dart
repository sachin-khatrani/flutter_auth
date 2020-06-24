import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterauthentication/model/user.dart';
import 'package:flutterauthentication/screens/authenticate/ProfileScreen.dart';
import 'package:flutterauthentication/screens/home/HomeScreen.dart';
import 'package:flutterauthentication/services/authentication.dart';
import 'package:flutterauthentication/services/database.dart';
import '../../Shared/clipper.dart';

class OtpVerification extends StatefulWidget {
  final String phoneNumber;
  OtpVerification({Key key, this.phoneNumber}) : super(key: key);
  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  //var phoneNumber;
  String verificationId, smsCode;
  bool codeSent = false;
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();
  FocusNode focusNode6 = FocusNode();
  String code = "";
  UserData userData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyPhone(widget.phoneNumber);
  }

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
                    "OTP VERIFICATION",
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
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            getPinField(key: "1", focusNode: focusNode1),
                            SizedBox(width: 5.0),
                            getPinField(key: "2", focusNode: focusNode2),
                            SizedBox(width: 5.0),
                            getPinField(key: "3", focusNode: focusNode3),
                            SizedBox(width: 5.0),
                            getPinField(key: "4", focusNode: focusNode4),
                            SizedBox(width: 5.0),
                            getPinField(key: "5", focusNode: focusNode5),
                            SizedBox(width: 5.0),
                            getPinField(key: "6", focusNode: focusNode6),
                            SizedBox(width: 5.0),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: RichText(
                            text: TextSpan(
                              text:
                                  'We will send you an One Time Password on this Mobile Number',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 70),
                          child: InkWell(
                            onTap: () {
                              verifyPhone(widget.phoneNumber);
                              print("Login using Email and Password tap");
                            },
                            child: RichText(
                              // RichText is used to styling a particular text span in a text by grouping them in one widget
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                text: 'Do not Receive OTP?',
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' Resend',
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
                              onTap: () {
                                var res = signIn(context);

                                if (res == false) {
                                  userData.phoneNumber = widget.phoneNumber;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProfileScreen(
                                                data: userData,
                                              )));
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                  'assets/fb_icon.png'), // loading custom images from assets in Flutter
                              // NOTE that if you have not addressed these images in pubspec.yaml then it will show error
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/g_plus_icon.png'),
                            ),
                          ],
                        ),
                      ],
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

  Widget getPinField({String key, FocusNode focusNode}) => SizedBox(
        height: 40.0,
        width: 35.0,
        child: TextField(
          key: Key(key),
          expands: false,
//          autofocus: key.contains("1") ? true : false,
          autofocus: false,
          focusNode: focusNode,
          onChanged: (String value) {
            if (value.length == 1) {
              code += value;
              switch (code.length) {
                case 1:
                  FocusScope.of(context).requestFocus(focusNode2);
                  break;
                case 2:
                  FocusScope.of(context).requestFocus(focusNode3);
                  break;
                case 3:
                  FocusScope.of(context).requestFocus(focusNode4);
                  break;
                case 4:
                  FocusScope.of(context).requestFocus(focusNode5);
                  break;
                case 5:
                  FocusScope.of(context).requestFocus(focusNode6);
                  break;
                default:
                  FocusScope.of(context).requestFocus(FocusNode());
                  break;
              }
            }
          },
          maxLengthEnforced: false,
          textAlign: TextAlign.center,
          cursorColor: Colors.white,
          keyboardType: TextInputType.number,
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                  bottom: 10.0, top: 30.0, left: 4.0, right: 4.0),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide:
                      BorderSide(color: Colors.blueAccent, width: 2.25)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Colors.white))),
        ),
      );

  //show snackbar
  _showSnackBar(String text, BuildContext context) {
    final snackBar = SnackBar(
      content: Text('$text'),
      duration: Duration(seconds: 2),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  //check otp is valid or not
  Future<bool> signIn(context) async {
    if (code.length != 6) {
      _showSnackBar("Invalid OTP", context);
    } else {
      var result =
          DatabaseService().checkUserWithPhoneNumber(widget.phoneNumber);

      await AuthService().signInWithOtp(smsCode, verificationId);
      return result;

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  //sent otp on given PhoneNumber
  Future<void> verifyPhone(phoneNumber) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeOut = (String verId) {
      this.verificationId = verId;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 30),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsOTPSent,
        codeAutoRetrievalTimeout: autoTimeOut);
  }
}
