import 'package:flutter/material.dart';

enum Fonts { sfPro, normal }

TextStyle textStyle(
    {Fonts? font,
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    TextDecoration? decoration}) {
  return TextStyle(
      color: color,
      decoration: decoration,
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontFamily: font == Fonts.normal ? null : "SF Pro");
}
