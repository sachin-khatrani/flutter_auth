import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//loading when we require
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[500],
      child: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
