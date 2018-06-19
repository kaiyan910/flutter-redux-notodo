import 'package:flutter/material.dart';

typedef void LocaleChangeCallback(Locale locale);

class APPLIC {

  final List<String> supportedLanguages = ['en','zh'];

  Iterable<Locale> supportedLocales() => supportedLanguages.map<Locale>((lang) => new Locale(lang, ''));

  LocaleChangeCallback onLocaleChanged;

  static final APPLIC _instance = new APPLIC._internal();

  factory APPLIC() => _instance;

  APPLIC._internal();
}
