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

  static const TextStyle greyTileStyle = TextStyle(
    color: AppColors.titleColor,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
  );

  static const TextStyle yellowTitleStyle = TextStyle(
    color: AppColors.secondColor,
    fontWeight: FontWeight.bold,
    fontSize: 13.0,
  );
}
