import 'package:flutter/material.dart';

abstract class Language {
  // 目前 App 所使用的語系物件
  static Language? of(BuildContext context) {
    return Localizations.of<Language>(context, Language);
  }

  String get appTitle;
  String get item1;
  String get item2;
  String get item3;
  String get select;
  String get itemDescription;
}
