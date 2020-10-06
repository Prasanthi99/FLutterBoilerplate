import 'package:flutter/material.dart';
import 'package:boilerplate/models/core/theme_context.dart';

class AppConstants {
  static const String APP_CONTEXT_KEY = "AppContext";
  static const String DarkTheme = "Dark";
  static const String LightTheme = "Light";
  static const String SystemDefault = "System Default";

  static const String THEMEKEY = "THEME";

  static const defaultThemeState = ThemeState.light;
  static const Color defaultPrimaryAccentColor = Color(0xFF0072CF);
  static const Color defaultSecondaryAccentColor = Color(0xFF40C4FF);
  static const int UserHiveAdapterId = 0;
  static const String userBox = "UserBox";
}
