import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:basic_note_app_frontend/data/repositories/apprepo.dart';
import 'package:basic_note_app_frontend/utils/logger.dart';
import 'package:basic_note_app_frontend/utils/result.dart';

class HomeViewModel extends ChangeNotifier {
  final AppRepo _repo = AppRepo();

  List<Note> _notes = [];
  int _page;
  int _limit;
  String _search = "";

  bool _selectVisibility = false;
  final pageInputController = TextEditingController();
  final limitInputController = TextEditingController();
  final searchInputController = TextEditingController();
  final pageInputFocusNode = FocusNode();
  final limitInputFocusNode = FocusNode();
  final searchInputFocusNode = FocusNode();

  HomeViewModel({int page = 1, int limit = 10}) : _limit = limit, _page = page {
    updateLimitInput();
    updatePageInput();
    pageInputFocusNode.addListener(() {
      if (!pageInputFocusNode.hasFocus) {
        logger.i('page lost focus ${pageInputController.text}');
        _page = int.tryParse(pageInputController.text) ?? 1;
        loadNotes();
      }
    });

    limitInputFocusNode.addListener(() {
      if (!limitInputFocusNode.hasFocus) {
        logger.i('limit lost focus ${limitInputController.text}');
        _limit = int.tryParse(limitInputController.text) ?? 10;
        loadNotes();
      }
    });

    searchInputFocusNode.addListener(() {
      if (!searchInputFocusNode.hasFocus) {
        _search = searchInputController.text;
        logger.i('search lost focus $_search');
        if (_search == "") {
          loadNotes();
        } else {
          searchNotes();
        }
        // loadNotes();
      }
    });
  }

  void updatePageInput() {
    pageInputController.text = _page.toString();
    if (_search == "") {
      loadNotes();
    } else {
      searchNotes();
    }
  }

  void updateLimitInput() {
    limitInputController.text = _limit.toString();
    loadNotes();
  }

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

  String get search => _search;
  set search(String val) {
    _search = val;
    notifyListeners();
  }

  List<Note> get notes => _notes;

  // load todos paginated
  Future<void> loadNotes() async {
    Result result = await _repo.loadNotes(page, limit);
    if (result is Ok) {
      logger.i('success loading notes');
      _notes = result.value;
    } else {
      logger.e("error loading notes");
    }
    notifyListeners();
  }

  Future<void> searchNotes() async {
    if (_search != "") {
      Result result = await _repo.searchNotes(page, limit, search);
      if (result is Ok) {
        logger.i('success searching notes');
        _notes = result.value;
      } else {
        logger.e("error searching notes");
      }
      notifyListeners();
    }
  }

  // delete a todo
  Future<void> deleteNote(int id) async {
    Result result = await _repo.deleteNote(id);
    if (result is Ok) {
      logger.i('success deleting note');
    } else {
      logger.e("error deleting note");
    }
    loadNotes();
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
