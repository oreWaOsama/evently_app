import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  final SharedPreferences prefs;
  late String currentLanguage;

  LanguageProvider(this.prefs) {
    _loadLanguage();
  }

  void _loadLanguage() {
    currentLanguage = prefs.getString('app_lang') ?? 'en';
  }

  void setLanguage(String languageCode) {
    if (currentLanguage == languageCode) {
      return;
    }
    currentLanguage = languageCode;
    prefs.setString('app_lang', languageCode);
    notifyListeners();
  }
}
