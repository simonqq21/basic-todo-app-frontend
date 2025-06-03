import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:basic_todo_app_frontend/data/repositories/apprepo.dart';
import 'package:basic_todo_app_frontend/utils/logger.dart';
import 'package:basic_todo_app_frontend/utils/result.dart';

class HomeViewModel extends ChangeNotifier {
  final AppRepo _repo = AppRepo();

  List<Note> _notes = [];
  int _page;
  int _limit;
  bool _selectVisibility = false;

  HomeViewModel({int page = 1, int limit = 10}) : _limit = limit, _page = page;

  bool get selectVisibility => _selectVisibility;
  set selectVisibility(val) {
    _selectVisibility = val;
    notifyListeners();
  }

  int get page => _page;
  set page(int val) {
    _page = val;
    notifyListeners();
  }

  int get limit => _limit;
  set limit(int val) {
    _limit = val;
    notifyListeners();
  }

  List<Note> get notes => _notes;
  // load todos paginated
  Future<void> loadNotes({int page = 1, int limit = 10}) async {
    Result result = await _repo.loadNotes(page, limit);
    if (result is Ok) {
      logger.i('success loading notes');
      _notes = result.value;
    } else {
      logger.e("error loading notes");
    }
    notifyListeners();
  }

  // delete a todo
  Future<void> deleteNote(int id) async {
    Result result = await _repo.deleteNote(id);
    if (result is Ok) {
      logger.i('success deleting note');
      _notes = result.value;
    } else {
      logger.e("error deleting note");
    }
    await loadNotes(page: _page, limit: _limit);
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
