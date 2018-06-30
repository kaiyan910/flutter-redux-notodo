import 'package:notodo/models/item.dart';

class AppState {

  final List<Item> items;

  AppState({this.items});

  factory AppState.init() => AppState(
      items: List.unmodifiable([])
  );
}
