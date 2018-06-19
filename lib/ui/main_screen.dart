import 'package:flutter/material.dart';
import 'package:notodo/dao/Item_dao.dart';
import 'package:notodo/locale/translations.dart';
import 'package:notodo/models/item.dart';
import 'package:notodo/ui/add_screen.dart';
import 'package:notodo/locale/applic.dart';
import 'package:notodo/utils/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_screen_list.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  DatabaseHelper _databaseHelper = DatabaseHelper();
  APPLIC _applic = new APPLIC();
  List _itemList;

  @override
  void initState() {
    super.initState();
    _getItems();
  }

  @override
  Widget build(BuildContext context) {

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
      body: Container(
        color: Colors.black26,
        padding: new EdgeInsets.all(8.0),
        child: MainScreenList(
          _itemList,
          removeCallback: (position, item) {
            _deleteItem(position, item.id);
          },
          editCallback: (position, item) {
            _editItem(position, item);
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        onPressed: _add,
        child: Icon(Icons.add),
      ),
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

  _editItem(int position, Item item) async {
    ItemDao itemDao = await _databaseHelper.itemDao;
    await itemDao.update(item);
    setState(() {
      _itemList.removeAt(position);
      _itemList.insert(position, item);
    });
  }

  _deleteItem(int position, int id) async {

    ItemDao itemDao = await _databaseHelper.itemDao;
    await itemDao.delete(id);

    setState(() {
      _itemList.removeAt(position);
    });
  }

  _getItems() async {

    ItemDao itemDao = await _databaseHelper.itemDao;
    List itemList   = await itemDao.all();

    setState(() {
      _itemList = itemList.map((item) => Item.fromMap(item)).toList();
    });
  }

  _add() async {

    var route = MaterialPageRoute<Map>(builder: (context) => AddScreen());
    Map results = await Navigator.of(context).push(route);

    if (results != null) {
      await _getItems();
    }
  }
}