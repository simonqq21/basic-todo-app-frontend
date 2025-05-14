import 'dart:collection';
import 'todo.dart';
export 'todo.dart';

class HomeModel {
  final List<Todo> _todos = [];
  get todos => _todos;
  // UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);
}

class SingleTodoModel {
  Todo? _todo;
  get todo => _todo;
  set todo(val) {
    _todo = val;
  }
}
