import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:basic_todo_app_frontend/utils/logger.dart';
import 'package:basic_todo_app_frontend/data/repositories/apprepo.dart';
import 'package:basic_todo_app_frontend/utils/result.dart';

class CreateTodoViewModel extends ChangeNotifier {
  final AppRepo _repo = AppRepo();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Todo _todo = Todo(title: "", body: "");

  Todo get todo => _todo;

  Future<void> loadTodo(int id) async {
    Result result = await _repo.loadTodo(id);
    if (result is Ok) {
      _todo = result.value;
      titleController.text = _todo.title;
      bodyController.text = _todo.body;
    } else {
      logger.e("error loading todo1");
    }
    notifyListeners();
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      logger.i("mnopqr");
      _todo = Todo(id: 1, title: titleController.text, body: "body123");
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
