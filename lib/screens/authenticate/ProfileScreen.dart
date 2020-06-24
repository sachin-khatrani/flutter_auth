import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterauthentication/model/user.dart';
import 'package:flutterauthentication/screens/home/HomeScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutterauthentication/services/authentication.dart';
import '../../Shared/widgets.dart';

class ProfileScreen extends StatefulWidget {
  UserData data;

  ProfileScreen({@required this.data});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  File profileImage;
  String userName;
  ImagePicker imagePicker = ImagePicker();

//open dialoge for choose image from camera or gallery
  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        _openGallery(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
//                    GestureDetector(
//                      child: Text("Camera"),
//                      onTap: () {
//                       // _openCamera(context);
//                      },
//                    )
                  ],
                ),
              ));
        });
  }

  var pick;
//open gallery for choose profile image
  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    //var p = imagePicker.getImage(source: ImageSource.gallery);
    this.setState(() {
      profileImage = picture;
      // pick = p;
    });
    Navigator.of(context).pop();
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
                    "PROFILE",
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
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 46, bottom: 30),
                  margin: EdgeInsets.only(top: 60, left: 20, right: 20),
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
                      Stack(
                        children: <Widget>[
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFe0f2f1),
                                image: DecorationImage(
                                    image: profileImage == null
                                        ? AssetImage('assets/avatar.png')
                                        : FileImage(profileImage),
                                    fit: BoxFit.fill)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40, top: 40),
                            child: InkWell(
                              onTap: () {
                                _showSelectionDialog(context);
                              },
                              child: Icon(Icons.add_a_photo),
                            ),
                          )
                        ],
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: MyTextFormField(
                                icon: Icon(Icons.email),
                                hintText: 'User Name',
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Enter your User name';
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  widget.data.userName = value;
                                },
                              ),
                            ),
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
                                  if (widget.data.email == null ||
                                      widget.data.email == "") {
                                    widget.data.email = value;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      new InkWell(
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            await _formKey.currentState.save();

                            if (profileImage == null || profileImage == "") {
                              _showSnackBar(
                                  'Please Select Profile Photo', context);
                            } else {
                              widget.data.photoUrl = "";
                              dynamic res = await AuthService()
                                  .registerEmailAndPassword(widget.data);
                              if (res != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              }
                            }
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
                          margin: EdgeInsets.only(top: 35, bottom: 35),
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
//    if (mounted) Scaffold.of(context).showSnackBar(snackBar);
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
