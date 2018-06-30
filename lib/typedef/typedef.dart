
import 'package:notodo/models/item.dart';

typedef OnItemAdd(String message);
typedef OnItemRemove(int position, Item item);
typedef OnItemEdit(int position, Item item);