import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:notodo/locale/applic.dart';
import 'package:notodo/locale/specific_localization_delegate.dart';
import 'package:notodo/locale/translations.dart';
import 'package:notodo/locale/translations_delegate.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notodo/redux/reducers/app_reducer.dart';
import 'package:notodo/redux/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_logging/redux_logging.dart';

import 'ui/main_screen.dart';

void main() => runApp(new NotoDoApp());

class NotoDoApp extends StatefulWidget {
  @override
  _NotoDoAppState createState() => _NotoDoAppState();
}

class _NotoDoAppState extends State<NotoDoApp> {

  final Store<AppState> _store = Store<AppState>(
    appReducer,
    initialState: AppState.init(),
    middleware: [
      new LoggingMiddleware(),
      thunkMiddleware,
    ],
  );

  SpecificLocalizationDelegate _localeOverrideDelegate;
  APPLIC _applic = new APPLIC();

  @override
  void initState() {
    super.initState();

    _localeOverrideDelegate = new SpecificLocalizationDelegate(null);
    _applic.onLocaleChanged = _onLocaleChange;

    _loadLocaleFromPreferences();
  }

  _loadLocaleFromPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String locale = preferences.getString("locale");

    setState(() {
      if (locale != null) {
        _localeOverrideDelegate = new SpecificLocalizationDelegate(new Locale(locale));
      }
    });
  }

  _onLocaleChange(Locale locale) {
    setState(() {
      _localeOverrideDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  @override
  Widget build(BuildContext context) {

    return new StoreProvider<AppState>(
      store: _store,
      child: new MaterialApp(
        onGenerateTitle: (context) => Translations.of(context).text('title'),
        home: MainScreen(),
        localizationsDelegates: [
          _localeOverrideDelegate,
          TranslationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: _applic.supportedLocales(),
          theme: ThemeData(
          brightness: Brightness.dark,
          iconTheme: IconThemeData(color: Colors.black),
          textTheme: TextTheme(title: TextStyle(color: Colors.black)),
          primaryColor: Colors.black,
          accentColor: Colors.greenAccent,
          errorColor: Colors.redAccent[100]),
        ),
    );
  }
}
