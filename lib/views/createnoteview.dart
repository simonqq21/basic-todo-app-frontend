import 'package:basic_todo_app_frontend/viewmodels/createnoteviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:basic_todo_app_frontend/utils/logger.dart';
import 'package:basic_todo_app_frontend/views/common.dart';
import 'package:basic_todo_app_frontend/viewmodels/createnoteviewmodel.dart';
import 'package:basic_todo_app_frontend/views/common/noteform.dart';

/// class for viewing a single todo
class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key});

  @override
  CreateNotePageState createState() => CreateNotePageState();
}

class CreateNotePageState extends State<CreateNotePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateNoteViewModel>(
      builder: (context, viewmodel, child) {
        return NotesForm(
          mode: "create",
          formKey: viewmodel.formKey,
          bodyController: viewmodel.bodyController,
          titleController: viewmodel.titleController,
          note: viewmodel.note,
        );
      },
    );
    // CreateNoteViewModel viewmodel = context.read();
    // return NotesForm(mode: "create");
  }
}
