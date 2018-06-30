import 'package:notodo/models/item.dart';
import 'package:notodo/redux/actions/item_action.dart';
import 'package:redux/redux.dart';

final Reducer<List<Item>> itemReducer = combineReducers([
  TypedReducer<List<Item>, RemoveItemAction>(_removeItem),
  TypedReducer<List<Item>, AddItemAction>(_addItem),
  TypedReducer<List<Item>, EditItemAction> (_editItem),
  TypedReducer<List<Item>, AddAllItemAction>(_addAllItems),
]);

List<Item> _removeItem(List<Item> itemList, RemoveItemAction action) => List.unmodifiable(List.from(itemList)..removeAt(action.position));

List<Item> _addItem(List<Item> itemList, AddItemAction action) => List.unmodifiable(List.from(itemList)..add(action.item));

List<Item> _editItem(List<Item> itemList, EditItemAction action) => List.unmodifiable(
    List.from(itemList)
      ..removeAt(action.position)
      ..insert(action.position, action.item)
);

List<Item> _addAllItems(List<Item> itemList, AddAllItemAction action) => List.unmodifiable(List.from(itemList)..addAll(action.items));