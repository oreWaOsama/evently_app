import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  final SharedPreferences prefs;
  late ThemeMode currentTheme;

  ThemeProvider(this.prefs) {
    _loadTheme();
  }

  void _loadTheme() {
    final themeString = prefs.getString('app_theme');
    if (themeString == 'dark') {
      currentTheme = ThemeMode.dark;
    } else if (themeString == 'light') {
      currentTheme = ThemeMode.light;
    } else {
      currentTheme = ThemeMode.dark; // Default
    }
  }

  void changeTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) {
      return;
    }

    currentTheme = newTheme;
    prefs.setString('app_theme', newTheme == ThemeMode.dark ? 'dark' : 'light');
    notifyListeners();
  }

  bool isDarkMode() {
    return currentTheme == ThemeMode.dark;
  }
}
