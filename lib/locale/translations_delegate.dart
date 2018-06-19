import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notodo/locale/applic.dart';
import 'package:notodo/locale/translations.dart';

class TranslationsDelegate extends LocalizationsDelegate<Translations> {

  APPLIC _applic = new APPLIC();

  TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => _applic.supportedLanguages.contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}