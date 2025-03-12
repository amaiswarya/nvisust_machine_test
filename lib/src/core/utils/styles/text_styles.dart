import 'package:flutter/material.dart';
import 'package:nvisust_test/src/core/utils/styles/app_colors.dart';
import 'package:nvisust_test/src/core/utils/styles/font_styles.dart';

class TextStyles {
  static TextStyle get blackprimary_12_400 => TextStyle(
      fontSize: FontSizes.xxsmall,
      fontWeight: FontWeight.w400,
      color: AppColors.blackPrimary);
  static TextStyle get red_12_400 => TextStyle(
      fontSize: FontSizes.xxsmall,
      fontWeight: FontWeight.w400,
      color: AppColors.red);
  static TextStyle get white_16_500 => TextStyle(
      fontSize: FontSizes.medium,
      fontWeight: FontWeight.w500,
      color: AppColors.white);
  static TextStyle get black_24_600 => TextStyle(
      fontSize: FontSizes.xlarge,
      fontWeight: FontWeight.w600,
      color: AppColors.blackPrimary);
}
