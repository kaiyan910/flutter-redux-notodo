import 'dart:async';

import 'package:sqflite/sqflite.dart';
import '../models/item.dart';
import 'dao.dart';

class ItemDao extends Dao<Item> {

  static const String TABLE_NAME = 'item';
  static const String COLUMN_ID = 'id';
  static const String COLUMN_TITLE = 'title';
  static const String COLUMN_CREATED_TIME = 'created_time';

  Database _database;

  ItemDao(this._database);

  static void createTable(Database database) async {

    await database.execute(
      'CREATE TABLE $TABLE_NAME('
      '$COLUMN_ID INTEGER PRIMARY KEY, '
      '$COLUMN_TITLE TEXT, '
      '$COLUMN_CREATED_TIME INTEGER'
      ')'
    );
  }

  @override
  Future<int> count() async {
    return Sqflite.firstIntValue(await _database.rawQuery('SELECT COUNT(*) FROM $TABLE_NAME'));
  }

  @override
  Future<int> delete(int id) async {

    return await _database.delete(
        TABLE_NAME,
        where: '$COLUMN_ID = ?',
        whereArgs: [id]
    );
  }

  @override
  Future<Item> one(int id) async {

    var result = await _database.rawQuery('SELECT * FROM $TABLE_NAME WHERE id = $id');
    if (result.length == 0) return null;
    return Item.fromMap(result.first);
  }

  @override
  Future<List> all() async {
    return await _database.rawQuery('SELECT * FROM $TABLE_NAME');
  }

  @override
  Future<int> save(Item record) async {
    return await _database.insert(TABLE_NAME, record.toMap());
  }

  @override
  Future<int> update(Item record) async {

    return await _database.update(
        TABLE_NAME,
        record.toMap(),
        where: '$COLUMN_ID = ?',
        whereArgs: [record.id]
    );
  }
}