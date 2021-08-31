// Mocks generated by Mockito 5.0.15 from annotations
// in sample/test/counter_middleware_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:redux/src/store.dart' as _i4;
import 'package:sample/app_state.dart' as _i5;
import 'package:sample/count_repository.dart' as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [CountRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCountRepository extends _i1.Mock implements _i2.CountRepository {
  MockCountRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<int> fetch() => (super.noSuchMethod(Invocation.method(#fetch, []),
      returnValue: Future<int>.value(0)) as _i3.Future<int>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [MiddlewareClass].
///
/// See the documentation for Mockito's code generation for more information.
class MockMiddleware extends _i1.Mock
    implements _i4.MiddlewareClass<_i5.AppState> {
  @override
  dynamic call(_i4.Store<_i5.AppState>? store, dynamic action,
          _i4.NextDispatcher? next) =>
      super.noSuchMethod(Invocation.method(#call, [store, action, next]));
  @override
  String toString() => super.toString();
}