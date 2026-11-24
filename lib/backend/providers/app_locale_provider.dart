import 'package:flutter/material.dart';

/// Holds the active bilingual locale (`en` or `ta`) for the app.
class AppLocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale next) {
    if (_locale == next) return;
    _locale = next;
    notifyListeners();
  }

  void toggleLocale() {
    setLocale(
      _locale.languageCode == 'en' ? const Locale('ta') : const Locale('en'),
    );
  }
}
