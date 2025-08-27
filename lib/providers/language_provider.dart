import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String currentLanguage = 'en';

  void setLanguage(String languageCode) {
    if (currentLanguage == languageCode) {
      return;
    }
    currentLanguage = languageCode;
    notifyListeners();
  }
}
