import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//textformfield with validation
class MyTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEmail;
  final Icon icon;
  final bool isPhoneNumber;
  MyTextFormField(
      {this.hintText,
        this.validator,
        this.onSaved,
        this.isPassword = false,
        this.isEmail = false,
        this.isPhoneNumber = false,
        this.icon});
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: "",
        decoration: InputDecoration(
          prefixIcon: icon,
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],

        ),
        obscureText: isPassword ? true : false,

        validator: validator,
        onSaved: onSaved,
        keyboardType: isEmail ? TextInputType.emailAddress : isPhoneNumber ? TextInputType.phone : TextInputType.text,
      ),
    );
  }
}

