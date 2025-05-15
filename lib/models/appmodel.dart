import 'dart:collection';
import 'todo.dart';
export 'todo.dart';

class HomeModel {
  final List<Todo> _todos = [];
  get todos => _todos;
  // UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);
}

class SingleTodoModel {
  Todo _todo = Todo(index: 0, title: "", body: "");
  // bool? _completed1 = false;

  get todo => _todo;
  set todo(val) {
    _todo = val;
  }

  // bool get completed1 => _todo.completed;
  // set completed1(bool val) {
  //   _todo.completed = val;
  // }

  // bool? get completed1 => _completed1;
  // set completed1(bool? val) => {_completed1 = val};
}
