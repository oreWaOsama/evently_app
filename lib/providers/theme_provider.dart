import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.dark;
  void changeTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) {
      return;
    }

    currentTheme = newTheme;
    notifyListeners();
  }

  bool isDarkMode() {
    return currentTheme == ThemeMode.dark;
  }
}
