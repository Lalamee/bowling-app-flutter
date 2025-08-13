import 'package:flutter/material.dart';

class CommonUI {
  static const double radius = 16;

  static BoxDecoration cardDecoration({
    Color color = Colors.white,
    double blur = 8,
    double spread = 0,
    Offset offset = const Offset(0, 2),
    Color shadow = const Color(0x0F000000),
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [BoxShadow(color: shadow, blurRadius: blur, spreadRadius: spread, offset: offset)],
    );
  }

  static Widget card({
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color color = Colors.white,
  }) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: cardDecoration(color: color),
      child: child,
    );
  }
}
