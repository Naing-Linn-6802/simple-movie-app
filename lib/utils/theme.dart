import 'package:flutter/material.dart';
import 'package:movie_app_by_nainglinn/utils/color_const.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: AppColors.mainColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.mainColor,
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: AppColors.secondColor),
  );
}
