import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sample/actions.dart';
import 'package:sample/app_state.dart';
import 'package:redux/redux.dart';
import 'package:sample/app_state_reducer.dart';
import 'package:sample/count_repository.dart';
import 'package:sample/counter_middleware.dart';

final Store<AppState> store = Store<AppState>(
  appStateReducer,
  initialState: const AppState(),
  middleware: [
    ...counterMiddleware(CountRepository()),
  ],
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider(store: store, child: App());
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, int>(
      converter: (store) => store.state.count,
      builder: (context, count) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
            appBar: AppBar(
              title: Text('Flutter Demo Home Page'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '$count',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                var store = StoreProvider.of<AppState>(context);
                store.dispatch(CountUpAction(store.state.count));
              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }
}
