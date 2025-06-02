import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:basic_todo_app_frontend/utils/logger.dart';
import 'package:basic_todo_app_frontend/data/repositories/apprepo.dart';
import 'package:basic_todo_app_frontend/utils/result.dart';

class CreateNoteViewModel extends ChangeNotifier {
  final AppRepo _repo = AppRepo();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Note _note = Note(title: "", body: "");

  Note get note => _note;

  Future<void> createNote(Note note) async {
    Result result = await _repo.createNote(note);
    if (result is Ok) {
      _note = result.value;
      titleController.text = _note.title;
      bodyController.text = _note.body;
    } else {
      logger.e("error creating note1");
    }
    notifyListeners();
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      // logger.i("mnopqr");
      // _note = Note(id: 1, title: titleController.text, body: "body123");
      notifyListeners();
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }
}
