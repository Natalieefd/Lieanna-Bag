import 'package:flutter/material.dart';

class ThemeModeData extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  int _selectedColorScheme = 0;
  int get selectedColorScheme => _selectedColorScheme;

  Color get containerColor {
    switch (_selectedColorScheme) {
      case 0:
        return Color.fromRGBO(226, 212, 224, 1);
      case 1:
        return Color.fromRGBO(101, 69, 31, 1);
      case 2:
        return Color.fromRGBO(154, 59, 59, 1);
      case 3:
        return Color.fromRGBO(130, 148, 196, 1);
      default:
        return Color.fromRGBO(226, 212, 224, 1);
    }
  }

  Color get container2Color {
    switch (_selectedColorScheme) {
      case 0:
        return Color.fromRGBO(225, 227, 223, 1);
      case 1:
        return Color.fromRGBO(234, 198, 150, 1);
      case 2:
        return Color.fromRGBO(255, 220, 220, 1);
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
