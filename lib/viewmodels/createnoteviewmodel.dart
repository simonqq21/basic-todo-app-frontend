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

  Future<void> createNote() async {
    logger.i("Creating note...");
    Result result = await _repo.createNote(note);
    if (result is Ok) {
      logger.i("Created note successfully.");
    } else {
      logger.e("error creating note1");
    }
    notifyListeners();
  }

  Future<bool> validateAndSave() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      _note.title = titleController.text;
      _note.body = bodyController.text;
      _note.dateModified = DateTime.now();
      await createNote();
      // _note = Note(
      //   id: 1,
      //   title: titleController.text,
      //   body: bodyController.text,
      //   completed: _note.completed,
      //   dateModified: DateTime.now(),
      // );
      notifyListeners();
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    logger.i("dispoesd");
    titleController.dispose();
    super.dispose();
  }
}
