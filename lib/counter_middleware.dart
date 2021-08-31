import 'package:redux/redux.dart';
import 'package:sample/actions.dart';
import 'package:sample/app_state.dart';
import 'package:sample/count_repository.dart';

List<Middleware<AppState>> counterMiddleware(
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
    try {
      next(action);
      final increaseCount = await repository.fetch();
      store.dispatch(CountUpSucceededAction(increaseCount));
    } catch (error) {
      store.dispatch(CountUpFailedAction());
    } finally {
      store.dispatch(CountUpCompleteAction());
    }
  };
}
