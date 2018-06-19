
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Translations {

  Locale _locale;
  static Map<dynamic, dynamic> _localizedValues = Map();

  Translations(this._locale);

  static Translations of(BuildContext context) => Localizations.of<Translations>(context, Translations);

  static Future<Translations> load(Locale locale) async {
    Translations translations = new Translations(locale);
    String jsonContent = await rootBundle.loadString("locale/i18n_${locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
    return translations;
  }

  String text(String key) {
    return _localizedValues[key] ?? '$key';
  }

  get currentLanguage => _locale.languageCode;
}