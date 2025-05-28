import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:basic_todo_app_frontend/data/repositories/appmodel.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeModel _model = HomeModel();

  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_model.todos);

  void add() {
    _model.f1();
    _model.todos.add(
      Todo(
        id: 0,
        title: 'My first todo',
        body: '',
        dateModified: DateTime(2022, 1, 2, 12, 0, 0),
      ),
    );
    _model.todos.add(
      Todo(
        id: 1,
        title: 'My second todo',
        body: '',
        dateModified: DateTime(2023, 1, 2, 12, 0, 0),
      ),
    );
    _model.todos.add(
      Todo(
        id: 2,
        title: 'My third todo',
        body: '',
        dateModified: DateTime(2024, 1, 2, 12, 0, 0),
      ),
    );
    _model.todos.add(
      Todo(
        id: 3,
        title: 'My fourth todo',
        body: '',
        dateModified: DateTime(2025, 1, 2, 12, 0, 0),
      ),
    );
    notifyListeners();
  }

  void removeAll() {
    _model.todos.clear();
    notifyListeners();
  }
}
