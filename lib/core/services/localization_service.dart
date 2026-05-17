import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class LocalizationService extends ChangeNotifier {
  Locale _currentLocale = const Locale('en');
  bool _isRtl = false;

  Locale get currentLocale => _currentLocale;
  bool get isRtl => _isRtl;

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
  ];

  static const Locale fallbackLocale = Locale('en');

  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString(AppConstants.localeKey) ?? 'en';
    await setLocale(Locale(langCode));
  }

  Future<void> setLocale(Locale locale) async {
    if (!supportedLocales.contains(locale)) return;
    _currentLocale = locale;
    _isRtl = locale.languageCode == 'ar';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.localeKey, locale.languageCode);
    notifyListeners();
  }

  Future<void> toggleLocale() async {
    if (_currentLocale.languageCode == 'en') {
      await setLocale(const Locale('ar'));
    } else {
      await setLocale(const Locale('en'));
    }
  }
}
