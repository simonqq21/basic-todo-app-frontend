import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:basic_todo_app_frontend/utils/logger.dart';
import 'package:basic_todo_app_frontend/views/common.dart';
import 'package:basic_todo_app_frontend/viewmodels/viewnoteviewmodel.dart';
import 'package:basic_todo_app_frontend/views/common/noteform.dart';

/// class for viewing a single todo
class SingleTodoPage extends StatefulWidget {
  final int id;
  const SingleTodoPage({super.key, this.id = 0});

  @override
  SingleTodoPageState createState() => SingleTodoPageState();
}

class SingleTodoPageState extends State<SingleTodoPage> {
  // bool? v1 = false;

  // SingleTodoPageState() {
  //   CreateTodoViewModel viewmodel = context.read();
  //   viewmodel.todo.id = id;
  // }

  @override
  void initState() {
    CreateTodoViewModel viewmodel = context.read();
    viewmodel.todo.id = widget.id;
    logger.i("create todo view model id = ${viewmodel.todo.id}");
    viewmodel.loadTodo(viewmodel.todo.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CreateTodoViewModel viewmodel = context.read();
    return NotesForm(title: "view", id: viewmodel.todo.id);
  }
}
