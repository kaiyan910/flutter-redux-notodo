import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:notodo/locale/translations.dart';
import 'package:notodo/redux/app_state.dart';
import 'package:notodo/redux/actions/item_action.dart';
import 'package:notodo/typedef/typedef.dart';

import 'add_screen_form.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text('${Translations.of(context).text('title')}'),
        textTheme: Theme.of(context).textTheme,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: new StoreConnector<AppState, OnItemAdd>(
        converter: (store) {
          return (message) async {
            var completer = new Completer();
            store.dispatch(addItem(message, completer));
            await completer.future;
            Navigator.pop(context);
          };
        },
        builder: (context, callback) {
          return AddScreenForm(
            onItemAdded: callback,
          );
        },
      ),//AddScreenForm(),
    );
  }
}


