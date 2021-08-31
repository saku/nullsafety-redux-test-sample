import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:sample/actions.dart';
import 'package:sample/app_state.dart';
import 'package:sample/app_state_reducer.dart';

main() {
  group("CountUpSucceededAction", () {
    final countUpValue = 3;
    test("count up default state", () {
      final store = Store<AppState>(
        appStateReducer,
        initialState: AppState(),
      );
      store.dispatch(CountUpSucceededAction(countUpValue));
      expect(store.state.count, countUpValue);
    });

    test("count up initial state", () {
      final initialCount = 5;
      final store = Store<AppState>(
        appStateReducer,
        initialState: AppState(count: initialCount),
      );
      store.dispatch(CountUpSucceededAction(countUpValue));
      expect(store.state.count, initialCount + countUpValue);
    });
  });
}
