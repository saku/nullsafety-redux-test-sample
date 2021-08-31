import 'package:meta/meta.dart';

@immutable
class AppState {
  final int count;

  const AppState({
    this.count = 0,
  });

  @override
  int get hashCode => count.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          count == other.count;

  @override
  String toString() {
    return "AppState{count: $count}";
  }
}
