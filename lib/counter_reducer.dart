import 'package:redux/redux.dart';
import 'package:sample/actions.dart';

final counterReducer = combineReducers<int>([
  TypedReducer<int, CountUpSucceededAction>((state, action) {
    final increaseCount = action.increaseCount;
    return state + increaseCount;
  }),
]);
