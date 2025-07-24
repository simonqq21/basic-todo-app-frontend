import 'package:basic_note_app_frontend/viewmodels/editnoteviewmodel.dart';
import 'package:basic_note_app_frontend/viewmodels/homeviewmodel.dart';
import 'package:basic_note_app_frontend/views/common/commonappbar.dart';
import 'package:basic_note_app_frontend/views/common/commonfloatingactionbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:basic_note_app_frontend/utils/logger.dart';
import 'package:basic_note_app_frontend/views/common.dart';
import 'package:basic_note_app_frontend/views/common/noteform.dart';

// class for editing a single todo
class EditNotePage extends StatefulWidget {
  final int id;
  const EditNotePage({super.key, this.id = 0});

  @override
  State<StatefulWidget> createState() => EditNotePageState();
}

class EditNotePageState extends State<EditNotePage> {
  @override
  void initState() {
    EditNoteViewModel viewmodel = context.read();
    viewmodel.note.id = widget.id;
    logger.i('edit note view model id = ${viewmodel.note.id}.');
    viewmodel.loadNote(viewmodel.note.id);
    // viewmodel.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditNoteViewModel>(
      builder: (context, viewmodel, child) {
        return Scaffold(
          appBar: NotesFormAppBar(title: "Edit NOte"),
          body: NotesForm(
            mode: 'edit',
            formKey: viewmodel.formKey,
            titleController: viewmodel.titleController,
            bodyController: viewmodel.bodyController,
            note: viewmodel.note,
          ),
          floatingActionButton: NotesFormFloatingActionButton(
            tooltip: 'Save note',
            icon: Icons.save,
            onPressed: () async {
              bool result = await viewmodel.validateAndSave();
              if (result) {
                viewmodel.note.completed = false;
                viewmodel.titleController.text = "";
                viewmodel.bodyController.text = "";
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: Text("Edit note success"),
                        content: Text("Note edited successfully."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // context.go('/');
                              while (context.canPop()) {
                                context.pop();
                              }
                              context.push('/');
                              while (context.canPop()) {
                                context.pop();
                              }
                            },
                            child: Text("Ok"),
                          ),
                        ],
                      ),
                );
              }
              logger.i("avavavavav");
            },
          ),
        );
      },
    );
  }
}
