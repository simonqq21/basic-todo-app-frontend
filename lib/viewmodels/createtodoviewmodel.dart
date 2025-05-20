import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:basic_todo_app_frontend/utils/logger.dart';
import 'package:basic_todo_app_frontend/data/repositories/appmodel.dart';

class CreateTodoViewModel extends ChangeNotifier {
  final SingleTodoModel _todo = SingleTodoModel();
  final titleController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  SingleTodoModel get todo => _todo;

  // bool? get completed => _todo.completed1;
  // set completed(bool? val) {
  //   _todo.completed1 = val;
  //   logger.i("a $val ${_todo.completed1}");
  //   notifyListeners();
  // }

  // bool get completed => _todo.completed1;
  // set completed(bool? val) {
  //   _todo.completed1 = val ?? false;
  //   logger.i("a $val ${_todo.completed1}");
  //   notifyListeners();
  // }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      logger.i("mnopqr");
      _todo.todo = Todo(index: 1, title: titleController.text, body: "body123");
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
