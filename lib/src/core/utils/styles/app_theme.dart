import 'package:flutter/material.dart';
import 'package:nvisust_test/src/core/utils/styles/app_colors.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.bgColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.bgColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.blackPrimary,
      ),
    ),
    dialogBackgroundColor: AppColors.bgColor,
    cardColor: AppColors.white,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.bgColor,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.bgColor,
    ),
  );
}
