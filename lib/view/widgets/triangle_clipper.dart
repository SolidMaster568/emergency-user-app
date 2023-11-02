import 'package:flutter/material.dart';

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    //Arranca desde la punta topLeft
    Path path = Path();
    path.lineTo(0, size.height * .95);
    path.lineTo(size.width, size.height * .7);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}