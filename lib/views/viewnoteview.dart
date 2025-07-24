import 'package:basic_note_app_frontend/views/common/commonappbar.dart';
import 'package:basic_note_app_frontend/views/common/commonfloatingactionbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:basic_note_app_frontend/utils/logger.dart';
import 'package:basic_note_app_frontend/views/common.dart';
import 'package:basic_note_app_frontend/viewmodels/viewnoteviewmodel.dart';
import 'package:basic_note_app_frontend/views/common/noteform.dart';

/// class for viewing a single todo
class ViewNotePage extends StatefulWidget {
  final int id;
  const ViewNotePage({super.key, this.id = 0});

  @override
  ViewNotePageState createState() => ViewNotePageState();
}

class ViewNotePageState extends State<ViewNotePage> {
  @override
  void initState() {
    ViewNoteViewModel viewmodel = context.read();
    viewmodel.note.id = widget.id;
    logger.i("create todo view model id = ${viewmodel.note.id}");
    viewmodel.loadNote(viewmodel.note.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewNoteViewModel>(
      builder: (context, viewmodel, child) {
        return Scaffold(
          appBar: NotesFormAppBar(title: "View NOte"),
          body: NotesForm(
            mode: 'view',
            formKey: viewmodel.formKey,
            titleController: viewmodel.titleController,
            bodyController: viewmodel.bodyController,
            note: viewmodel.note,
          ),
          // Container(
          //   child: SizedBox(height: 100, width: 100, child: Text("abcxyz")),
          // ),
          floatingActionButton: NotesFormFloatingActionButton(
            onPressed: () async {
              context.push('/notes/${viewmodel.note.id}/edit');
              // logger.i("vavavavava");
            },
            tooltip: 'Edit note',
            icon: Icons.edit,
          ),
        );
      },
    );
  }
}
