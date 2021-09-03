import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import 'package:sample/actions.dart';
import 'package:sample/app_state.dart';
import 'package:sample/app_state_reducer.dart';
import 'package:sample/count_repository.dart';
import 'package:sample/failed_counter_middleware.dart';

import 'counter_middleware_test.mocks.dart';

@GenerateMocks([
  CountRepository,
], customMocks: [
  MockSpec<MiddlewareClass<AppState>>(
    as: #MockMiddleware,
    returnNullOnMissingStub: true,
  )
])
main() {
  final repository = MockCountRepository();
  final watcher = MockMiddleware();

  group("fetch", () {
    test("fetch doesn't throw error", () async {
      final store = Store<AppState>(
        appStateReducer,
        initialState: AppState(),
        middleware: failedCounterMiddleware(repository)..add(watcher),
      );

      final countUpValue = 1;
      when(repository.fetch()).thenAnswer((_) => Future.value(countUpValue));

      store.dispatch(CountUpAction(334));

      await untilCalled(
        store.dispatch(
          isA<CountUpCompleteAction>(),
        ),
      );

      verify(repository.fetch());
      verify(watcher.call(
        store,
        predicate((action) => action is CountUpAction),
        any,
      ));
      verify(watcher.call(
        store,
        predicate((action) {
          if (action is CountUpSucceededAction) {
            return action.increaseCount == countUpValue;
          }
          return false;
        }),
        any,
      ));
      verifyNever(watcher.call(
        store,
        predicate((action) => action is CountUpFailedAction),
        any,
      ));
      verify(watcher.call(
        store,
        predicate((action) => action is CountUpCompleteAction),
        any,
      ));
    });

    test("fetch throws error", () async {
      final store = Store<AppState>(
        appStateReducer,
        initialState: AppState(),
        middleware: failedCounterMiddleware(repository)..add(watcher),
      );

      when(repository.fetch()).thenThrow(Exception("some"));

      store.dispatch(CountUpAction(0));

      await untilCalled(
        store.dispatch(
          isA<CountUpCompleteAction>(),
        ),
      );

      verify(repository.fetch());
      verify(watcher.call(
        store,
        predicate((action) => action is CountUpAction),
        any,
      ));
      verifyNever(watcher.call(
        store,
        predicate((action) => action is CountUpSucceededAction),
        any,
      ));
      verify(watcher.call(
        store,
        predicate((action) => action is CountUpFailedAction),
        any,
      ));
      verify(watcher.call(
        store,
        predicate((action) => action is CountUpCompleteAction),
        any,
      ));
    });
  });
}
