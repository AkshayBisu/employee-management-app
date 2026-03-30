import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF2F6FED);
  static const green = Color(0xFF4CAF50);
}

ThemeData lightTheme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: Colors.white,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
);