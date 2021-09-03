import 'package:redux/redux.dart';
import 'package:sample/actions.dart';
import 'package:sample/app_state.dart';
import 'package:sample/count_repository.dart';

List<Middleware<AppState>> failedCounterMiddleware(
  CountRepository repository,
) {
  return [
    TypedMiddleware<AppState, CountUpAction>(_fetch(repository)),
  ];
}

void Function(
  Store<AppState> store,
  CountUpAction action,
  NextDispatcher next,
) _fetch(
  CountRepository repository,
) {
  return (store, action, next) async {
    next(action);
    repository.fetch().then((increaseCount) {
      store.dispatch(CountUpSucceededAction(increaseCount));
    }).catchError((error) {
      store.dispatch(CountUpFailedAction());
    }).whenComplete(() {
      store.dispatch(CountUpCompleteAction());
    });
  };
}
