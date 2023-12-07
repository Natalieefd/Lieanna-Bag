import 'package:flutter/material.dart';

class ThemeModeData extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  int _selectedColorScheme = 0;
  int get selectedColorScheme => _selectedColorScheme;

  Color get containerColor {
    switch (_selectedColorScheme) {
      case 0:
        return Color.fromRGBO(231, 188, 222, 1);
      case 1:
        return Color.fromRGBO(255, 194, 111, 1);
      case 2:
        return Color.fromRGBO(255, 180, 180, 1);
      case 3:
        return Color.fromRGBO(130, 148, 196, 1);
      default:
        return Color.fromRGBO(226, 212, 224, 1);
    }
  }

  Color get container2Color {
    switch (_selectedColorScheme) {
      case 0:
        return Color.fromRGBO(219, 223, 234, 1);
      case 1:
        return Color.fromRGBO(255, 245, 194, 1);
      case 2:
        return Color.fromRGBO(253, 240, 240, 1);
      case 3:
        return Color.fromRGBO(219, 223, 234, 1);
      default:
        return Color(0xE2D4E0);
    }
  }

  Color get textColor => Colors.white;

  void setColorScheme(int colorScheme) {
    _selectedColorScheme = colorScheme;
    notifyListeners();
  }

  void changeTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}
