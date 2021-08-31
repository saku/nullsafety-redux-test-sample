import 'package:sample/app_state.dart';
import 'package:sample/counter_reducer.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    count: counterReducer(
      state.count,
      action,
    ),
  );
}
