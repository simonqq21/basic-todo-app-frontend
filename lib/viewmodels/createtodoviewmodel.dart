import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:basic_todo_app_frontend/utils/logger.dart';
import 'package:provider/provider.dart';
import 'package:basic_todo_app_frontend/models/appmodel.dart';

class CreateTodoViewModel extends ChangeNotifier {
  final SingleTodoModel _todo = SingleTodoModel();
  final titleController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  SingleTodoModel? get todo => _todo;

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
