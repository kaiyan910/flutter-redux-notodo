import 'package:notodo/dao/Item_dao.dart';

class Item {

  int _id;
  String _title;
  int _createdTime;

  Item(this._title, this._createdTime);

  Item.map(dynamic obj) {
    this._id = obj[ItemDao.COLUMN_ID];
    this._title = obj[ItemDao.COLUMN_TITLE];
    this._createdTime = obj[ItemDao.COLUMN_CREATED_TIME];
  }

  Item.fromMap(Map<String, dynamic> map) {
    this._id = map[ItemDao.COLUMN_ID];
    this._title = map[ItemDao.COLUMN_TITLE];
    this._createdTime = map[ItemDao.COLUMN_CREATED_TIME];
  }

  int get id => _id;
  String get title => _title;
  int get createdTime => _createdTime;

  set title(String value) {
    this._title = value;
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map[ItemDao.COLUMN_ID] = _id;
    map[ItemDao.COLUMN_TITLE] = _title;
    map[ItemDao.COLUMN_CREATED_TIME] = _createdTime;
    return map;
  }
}