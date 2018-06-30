
import 'dart:async';

import 'package:notodo/dao/Item_dao.dart';
import 'package:notodo/models/item.dart';
import 'package:notodo/redux/app_state.dart';
import 'package:notodo/utils/database_helper.dart';
import 'package:redux/redux.dart';

class AddAllItemAction {

  final List<Item> items;

  AddAllItemAction(this.items);

}

class AddItemAction {

  final Completer completer = new Completer();
  final Item item;

  AddItemAction(this.item);
}

class RemoveItemAction {

  final int position;

  RemoveItemAction(this.position);
}

class EditItemAction {

  final int position;
  final Item item;

  EditItemAction(this.position, this.item);
}

Function getItem = (Store<AppState> store) async {

  DatabaseHelper databaseHelper = DatabaseHelper();

  ItemDao itemDao = await databaseHelper.itemDao;
  List itemList = await itemDao.all();

  store.dispatch(AddAllItemAction(itemList.map((item) => Item.fromMap(item)).toList()));
};

Function deleteItem(int position, int id) => (Store<AppState> store) async {

  DatabaseHelper databaseHelper = DatabaseHelper();

  ItemDao itemDao = await databaseHelper.itemDao;
  await itemDao.delete(id);

  store.dispatch(RemoveItemAction(position));
};

Function editItem(int position, Item item) => (Store<AppState> store) async {

  DatabaseHelper databaseHelper = DatabaseHelper();

  ItemDao itemDao = await databaseHelper.itemDao;
  await itemDao.update(item);

  store.dispatch(EditItemAction(position, item));
};

Function addItem(String message, Completer completer) => (Store<AppState> store) async {

  DatabaseHelper databaseHelper = DatabaseHelper();

  Item item = Item(message, DateTime.now().millisecondsSinceEpoch);

  ItemDao itemDao = await databaseHelper.itemDao;
  await itemDao.save(item);

  store.dispatch(AddItemAction(item));
  completer.complete();
};