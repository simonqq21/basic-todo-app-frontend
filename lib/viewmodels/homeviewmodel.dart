import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:basic_todo_app_frontend/data/repositories/apprepo.dart';
import 'package:basic_todo_app_frontend/utils/logger.dart';
import 'package:basic_todo_app_frontend/utils/result.dart';

class HomeViewModel extends ChangeNotifier {
  final AppRepo _repo = AppRepo();

  List<Todo> _todos = [];
  int _page;
  int _limit;

  int get page => _page;
  set page(int val) => _page = val;

  int get limit => _limit;
  set limit(int val) => _limit = val;

  HomeViewModel({int page = 1, int limit = 10}) : _limit = limit, _page = page;
  List<Todo> get todos => _todos;

  // UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  // load todos paginated
  Future<void> loadTodos({int page = 1, int limit = 10}) async {
    Result result = await _repo.loadTodos(page, limit);
    if (result is Ok) {
      logger.i('success loading todos');
      _todos = result.value;
    } else {
      logger.e("error loading todos");
    }
    notifyListeners();
  }

  // delete a todo
  Future<void> deleteTodo(int id) async {
    Result result = await _repo.deleteTodo(id);
    if (result is Ok) {
      logger.i('success deleting todo');
      _todos = result.value;
    } else {
      logger.e("error deleting todo");
    }
    await loadTodos(page: _page, limit: _limit);
    notifyListeners();
  }
  // void add() {
  //   _todos.add(
  //     Todo(
  //       id: 0,
  //       title: 'My first todo',
  //       body: '',
  //       dateModified: DateTime(2022, 1, 2, 12, 0, 0),
  //     ),
  //   );
  //   _todos.add(
  //     Todo(
  //       id: 1,
  //       title: 'My second todo',
  //       body: '',
  //       dateModified: DateTime(2023, 1, 2, 12, 0, 0),
  //     ),
  //   );
  //   _todos.add(
  //     Todo(
  //       id: 2,
  //       title: 'My third todo',
  //       body: '',
  //       dateModified: DateTime(2024, 1, 2, 12, 0, 0),
  //     ),
  //   );
  //   _todos.add(
  //     Todo(
  //       id: 3,
  //       title: 'My fourth todo',
  //       body: '',
  //       dateModified: DateTime(2025, 1, 2, 12, 0, 0),
  //     ),
  //   );
  //   notifyListeners();
  // }

  // void removeAll() {
  //   _todos.clear();
  //   notifyListeners();
  // }
}
