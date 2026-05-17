import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalization {
  final Locale locale;

  AppLocalization(this.locale);

  static const LocalizationsDelegate<AppLocalization> delegate = _AppLocalizationDelegate();

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

  static Future<AppLocalization> load(Locale locale) async {
    Intl.defaultLocale = locale.languageCode;
    return AppLocalization(locale);
  }
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) => AppLocalization.load(locale);

  @override
  bool shouldReload(_AppLocalizationDelegate old) => false;
}
