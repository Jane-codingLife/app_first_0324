import 'package:flutter/material.dart';
import 'package:app_first_0324/locale/language.dart';
import 'language_en.dart';
import 'language_zh.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Language> {
  const AppLocalizationsDelegate();

  // 切換的格式
  @override
  bool isSupported(Locale locale) {
    return const ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<Language> load(Locale locale) {
    return _load(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<Language> old) {
    return false;
  }

  static Future<Language> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'zh':
        return LanguageZh();
      default:
        return LanguageEn();
    }
  }
  
}
