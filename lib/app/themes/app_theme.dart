import 'package:flutter/material.dart';
import '/app/app.dart';

enum MyTheme { light, dark }
enum MyGradient { neon, galaxy }

class AppTheme {
  static final Map<MyTheme, ThemeData> _themes = {
    MyTheme.dark: ThemeData(
      useMaterial3: true,
      highlightColor: AppColors.darkHighlight,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.darkPrimary,
        onPrimary: Colors.white,
        secondary: AppColors.darkSecondary,
        onSecondary: Colors.white,
        error: AppColors.error,
        onError: Colors.white,
        surface: AppColors.darkSurface,
        onSurface: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.darkSurface,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkSurface,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkPrimary,
          foregroundColor: Colors.white,
        ),
      ),
    ),
    MyTheme.light: ThemeData(
      useMaterial3: true,
      highlightColor: AppColors.darkHighlight,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.lightPrimary,
        onPrimary: Colors.black,
        secondary: AppColors.lightSecondary,
        onSecondary: Colors.white,
        error: AppColors.error,
        onError: Colors.white,
        surface: AppColors.lightSurface,
        onSurface: Colors.black,
      ),
      scaffoldBackgroundColor: AppColors.lightSurface,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: Colors.black,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightPrimary,
          foregroundColor: Colors.white,
        ),
      ),
    ),
  };

  static final Map<MyGradient, List<Color>> _gradients = {
    MyGradient.neon: [Color(0xCC40C4FF), Color(0xCCE040FB), Color(0xCCFF4081)],
    MyGradient.galaxy: [Color(0xCC40C4FF), Color(0xCC7C4DFF), Color(0xCC311B92)],
  };

  static get currGrade =>
      (MyGradient x) => _gradients[x];
  static get currTheme =>
      (MyTheme x) => _themes[x];
}
