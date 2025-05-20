import 'package:basic_todo_app_frontend/data/services/dbservice.dart';

import '../models/todo.dart';
import '../../utils/logger.dart';
export '../models/todo.dart';

class HomeModel {
  final List<Todo> _todos = [];
  TodoDBService todoDbService = TodoDBService();

  get todos => _todos;

  void f1() async {
    logger.d(todoDbService.getTodo());
  }

  // UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);
}

class SingleTodoModel {
  Todo _todo = Todo(index: 0, title: "", body: "");
  TodoDBService todoDbService = TodoDBService();

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
