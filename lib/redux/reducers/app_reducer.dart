import 'package:notodo/redux/app_state.dart';
import 'package:notodo/redux/reducers/reducers.dart';

AppState appReducer(AppState state, action) => AppState(
  items: itemReducer(state.items, action),
);