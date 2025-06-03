import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:basic_todo_app_frontend/utils/logger.dart';
import 'package:basic_todo_app_frontend/views/common.dart';
import 'package:basic_todo_app_frontend/viewmodels/viewnoteviewmodel.dart';
import 'package:basic_todo_app_frontend/views/common/noteform.dart';

/// class for viewing a single todo
class ViewNotePage extends StatefulWidget {
  final int id;
  const ViewNotePage({super.key, this.id = 0});

  @override
  ViewNotePageState createState() => ViewNotePageState();
}

class ViewNotePageState extends State<ViewNotePage> {
  // bool? v1 = false;

  // SingleTodoPageState() {
  //   CreateTodoViewModel viewmodel = context.read();
  //   viewmodel.todo.id = id;
  // }

  @override
  void initState() {
    ViewNoteViewModel viewmodel = context.read();
    viewmodel.note.id = widget.id;
    logger.i("create todo view model id = ${viewmodel.note.id}");
    viewmodel.loadTodo(viewmodel.note.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ViewNoteViewModel viewmodel = context.read();
    return NotesForm(mode: "view");
  }
}
