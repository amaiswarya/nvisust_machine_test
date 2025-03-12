import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get heavy => copyWith(fontWeight: FontWeight.w700);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get normal => copyWith(fontWeight: FontWeight.w400);
  TextStyle withColor(Color color) => copyWith(color: color);
}
