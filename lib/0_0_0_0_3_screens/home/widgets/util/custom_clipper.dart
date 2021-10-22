import 'package:flutter/material.dart';


///
///* CLIPPER TO PRODUCE COLORED SHINE EFFECT ON CIRCULAR BUTTONS 
///
class MyCustomClipper extends CustomClipper<Path> {
  MyCustomClipper();

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 180);
    path.lineTo(80, -90);
    path.lineTo(80, 80);
    path.lineTo(0, 80);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

class MyCustomClipper2 extends CustomClipper<Rect> {
  MyCustomClipper2();

  @override
  Rect getClip(Size size) {
    return const Rect.fromLTRB(0, 0, 80, 80);
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
