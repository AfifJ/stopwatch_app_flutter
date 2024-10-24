import 'package:flutter/material.dart';

class AppTheme {
  static const primary = Color.fromRGBO(0, 74, 201, 1);

  static const danger = Color.fromRGBO(215, 58, 73, 1); // Red
  static const warning = Color.fromRGBO(249, 197, 19, 1); // Yellow
  static const success = Color.fromRGBO(40, 167, 69, 1); // Green

  static const muted = Color.fromRGBO(240, 240, 240, 0.959);
  static const dark = Color.fromRGBO(18, 18, 18, 1);

  static const double rounded = 16;

  static const double bodyOpacity = 0.5;

  static Color mutedTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? Colors.black.withOpacity(AppTheme.bodyOpacity)
        : Colors.white.withOpacity(AppTheme.bodyOpacity);
  }

  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? Colors.black
        : Colors.white;
  }
}
