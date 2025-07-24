import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:basic_note_app_frontend/utils/logger.dart';
import 'package:basic_note_app_frontend/data/repositories/apprepo.dart';
import 'package:basic_note_app_frontend/utils/result.dart';

class EditNoteViewModel extends ChangeNotifier {
  final AppRepo _repo = AppRepo();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Note _note = Note(title: "", body: "");
  Note get note => _note;

  // validate and save form
  Future<bool> validateAndSave() async {
    final form = formKey.currentState;
    logger.i("validateAndSave");
    if (form!.validate()) {
      _note.title = titleController.text;
      _note.body = bodyController.text;
      _note.updatedAt = DateTime.now();
      await updateNote();
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> loadNote(int id) async {
    Result result = await _repo.loadNote(id);
    if (result is Ok) {
      _note = result.value;
      titleController.text = _note.title;
      bodyController.text = _note.body;
    } else {
      logger.e("error loading note1");
    }
    notifyListeners();
  }

  // modify note in database
  Future<void> updateNote() async {
    logger.i("Editing note...");
    _note.updatedAt = DateTime.now();
    Result result = await _repo.editNote(_note.id, _note);
    if (result is Ok) {
      logger.i("Edited note successfully");
    } else {
      logger.e("Error editing note.");
    }
    notifyListeners();
  }

  @override
  void dispose() {
    logger.i("dispoesd");
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }
}
