import 'package:flutter/material.dart';
import 'package:notodo/locale/translations.dart';
import 'package:notodo/redux/app_state.dart';
import 'package:notodo/locale/applic.dart';
import 'package:notodo/ui/add_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:notodo/redux/actions/item_action.dart';

import 'main_screen_list.dart';

class MainScreen extends StatefulWidget {

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  APPLIC _applic = new APPLIC();

  @override
  Widget build(BuildContext context) {

    return StoreBuilder<AppState>(
      onInit: (store) => store.dispatch(getItem),
      builder: (context, store) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).accentColor,
            title: Text(
              Translations.of(context).text('title'),
            ),
            textTheme: Theme.of(context).textTheme,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.language,
                  color: Colors.black,
                ),
                onPressed: _showLanguageBottomSheet,
              ),
            ],
          ),
          body: StoreConnector<AppState, List>(
            converter: (store) => store.state.items,
            builder: (context, items) {
              return Container(
                color: Colors.black26,
                padding: new EdgeInsets.all(8.0),
                child: MainScreenList(
                    items,
                    removeCallback: (position, item) {
                      store.dispatch(deleteItem(position, item.id));
                    },
                    editCallback: (position, item) {
                      store.dispatch(editItem(position, item));
                    }
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).accentColor,
            onPressed: _add,
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }

  _showLanguageBottomSheet() {

    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: new EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Expanded(
                child: FlatButton(
                  child: Text(
                    'English',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  color: Colors.greenAccent,
                  onPressed: () {
                    _applic.onLocaleChanged(new Locale('en'));
                    _updateLocale('en');
                    Navigator.of(context).pop();
                  },
                ),
              ),
              new Padding(
                padding: EdgeInsets.only(right: 16.0)
              ),
              new Expanded(
                child: FlatButton(
                  child: Text(
                    '中文',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  color: Colors.greenAccent,
                  onPressed: () {
                    _applic.onLocaleChanged(new Locale('zh'));
                    _updateLocale('zh');
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          )
        );
      }
    );
  }

  _updateLocale(String locale) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('locale', locale);
  }

  _add() async {

    var route = MaterialPageRoute<Map>(builder: (context) => AddScreen());
    await Navigator.of(context).push(route);
  }
}