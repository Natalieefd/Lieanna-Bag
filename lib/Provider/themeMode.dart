import 'package:flutter/material.dart';

class ThemeModeData extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkModeActive => _themeMode == ThemeMode.dark;

  void changeTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}