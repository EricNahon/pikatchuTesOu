import 'package:flutter/material.dart';

class DrawHorizontalLine extends CustomPainter {
  Paint _paint;
  bool reverse;

  DrawHorizontalLine(this.reverse) {
    _paint = Paint()
      ..color = Colors.indigo[600]
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if(!reverse){
      canvas.drawLine(Offset(0.0, 0.0), Offset(size.width, 0.0), _paint);
    }
    else
    {
      canvas.drawLine(Offset(-size.width, 0.0), Offset(0.0, 0.0), _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}