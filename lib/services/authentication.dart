import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutterauthentication/model/user.dart';
import 'package:flutterauthentication/screens/authenticate/authenticate.dart';
import 'package:flutterauthentication/screens/home/HomeScreen.dart';
import 'package:flutterauthentication/services/database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final AuthService _instance = AuthService._internal();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map((FirebaseUser firebaseUser) => _userFromFirebaseUser(firebaseUser));
  }

//return userid
  User _userFromFirebaseUser(FirebaseUser user){

    return user != null ? User(uid: user.uid) : null;
  }

  //register in using email & password
  Future registerEmailAndPassword(userData) async {

    UserData userdata = userData;
    try{
      AuthResult result = await  _auth.createUserWithEmailAndPassword(email: userdata.email, password: userdata.password);
      FirebaseUser user = result.user;
      User userData;
      if(user != null){
          userData = User(
            uid: user.uid,
            userName: userdata.userName,
            fullName: userdata.fullName,
            email: userdata.email,
            phoneNumber: userdata.phoneNumber,
            photoUrl: userdata.photoUrl
          );
      }
      await DatabaseService(uid: user.uid).updateData(userData);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in using email and password

  Future signInWithEmailAndPassword(String email,String pass) async {
    try{
      AuthResult result = await  _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{

    try{
      return _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

 //check credencial for otp
  signIn(AuthCredential authCredential){
    _auth.signInWithCredential(authCredential);
  }

  //signInWithOtp
  signInWithOtp(smsCode,verid){
      AuthCredential authCredential = PhoneAuthProvider.getCredential(verificationId: verid, smsCode: smsCode);
      signIn(authCredential);
  }

  //reserPassword for email
  @override
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  //FacebookSignIn
  var facebookLogin = FacebookLogin();

  Future<bool> initiateFacebookLogin() async {
    var facebookLoginResult =
    await facebookLogin.logInWithReadPermissions(['email']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        return false;
        break;
      case FacebookLoginStatus.cancelledByUser:
        return false;
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult
                .accessToken.token}');

        var profile = json.decode(graphResponse.body);
        print(profile['id']);
        DatabaseService(uid: profile['id']).checkFacebookUser(profile);

        return true;
        break;
    }
  }

  //google signIn
//  Future<FirebaseUser> handleSignIn() async {
//    FirebaseUser user;
//    bool userSignedIn = await _googleSignIn.isSignedIn();
//
//      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//      final AuthCredential credential = GoogleAuthProvider.getCredential(
//        accessToken: googleAuth.accessToken,
//        idToken: googleAuth.idToken,
//      );
//
//      user = (await _auth.signInWithCredential(credential)).user;
//      userSignedIn = await _googleSignIn.isSignedIn();
//
//    return user;
//  }
}