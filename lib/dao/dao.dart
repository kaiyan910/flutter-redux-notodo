import 'dart:async';

import 'package:sqflite/sqflite.dart';

abstract class Dao<T> {

  Future<int> save(T record);
  Future<List> all();
  Future<int> count();
  Future<T> one(int id);
  Future<int> delete(int id);
  Future<int> update(T record);
}