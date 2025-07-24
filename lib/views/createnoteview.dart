import 'package:basic_note_app_frontend/viewmodels/createnoteviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:basic_note_app_frontend/utils/logger.dart';
import 'package:basic_note_app_frontend/views/common.dart';
import 'package:basic_note_app_frontend/views/common/noteform.dart';
import 'package:basic_note_app_frontend/views/common/commonappbar.dart';
import 'package:basic_note_app_frontend/views/common/commonfloatingactionbutton.dart';

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
        return Scaffold(
          appBar: NotesFormAppBar(title: "Create NOte"),
          body: NotesForm(
            mode: 'create',
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
              bool result = await viewmodel.validateAndSave();

              if (result) {
                viewmodel.note.completed = false;
                viewmodel.titleController.text = "";
                viewmodel.bodyController.text = "";
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: Text("Create note success"),
                        content: Text("Note created successfully."),
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
              logger.i("vavavavava");
            },
            tooltip: 'Save note',
            icon: Icons.save,
          ),
        );
      },
    );
  }
}

// return NotesForm(
        //   mode: "create",
        //   formKey: viewmodel.formKey,
        //   bodyController: viewmodel.bodyController,
        //   titleController: viewmodel.titleController,
        //   note: viewmodel.note,
        //   submitAction: viewmodel.validateAndSave,
        //   // onPressed: () async {
        //   //   logger.d("save new note button pressed");

        //   //   await viewmodel.validateAndSave();
        //   //   // await widget.submitAction(widget.note);
        //   //   // await viewmodel.
        //   //   // Navigator.push(
        //   //   //   context,
        //   //   //   MaterialPageRoute(builder: (context) => const SingleTodoPage()),
        //   //   // );
        //   //   // context.push('/todo');
        //   //   context.go('/');
        //   // },
        // );

// Container(
//       padding: EdgeInsets.only(top: 25),
//       alignment: Alignment.topCenter,
//       child: SizedBox(
//         width: 1200,
//         height: 750,
//         child: Form(
//           key: viewmodel.formKey,
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("title: ", style: globalTextStyle),
//                   SizedBox(
//                     width: 600,
//                     child: TextFormField(
//                       style: globalTextStyle,
//                       controller: viewmodel.titleController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Title',
//                       ),
//                       enabled: true,
//                       validator: (val) {
//                         if (val == null || val.isEmpty || val == "") {
//                           return 'Please enter the title.';
//                         }
//                         return null;
//                       },
//                       // onSaved: (val) {
//                       //   logger.i("ghijkl");
//                       //   viewmodel.todo.title = val!;
//                       // },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               SizedBox(
//                 width: 1200,
//                 height: 580,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Body:"),
//                         SizedBox(height: 20),
//                         SizedBox(
//                           width: 600,
//                           height: 480,
//                           child: TextFormField(
//                             textAlignVertical: TextAlignVertical.top,
//                             expands: true,
//                             maxLines: null,
//                             keyboardType: TextInputType.multiline,
//                             decoration: InputDecoration(
//                               labelText: 'Body xyz',
//                               border: OutlineInputBorder(),
//                             ),
//                             controller: viewmodel.bodyController,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(width: 20),
//                     Container(
//                       color: Colors.blue[300],
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text("Completed: "),
//                               Checkbox(
//                                 value: viewmodel.note?.completed,
//                                 // tristate: true,
//                                 // onChanged: (bool? val) {
//                                 //   // setState(() {});
//                                 //   viewmodel.completed = val;
//                                 //   logger.i('$val => ${viewmodel.completed}');
//                                 // },
//                                 onChanged: (bool? val) {
//                                   setState(() {
//                                     viewmodel.note.completed = val ?? false;
//                                   });
//                                   // viewmodel.completed = val;
//                                   // logger.i('$val => ${viewmodel.completed}');
//                                   logger.i(
//                                     '$val => ${viewmodel.note.completed}',
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),

//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.center,
//               //   children: [
//               //     SizedBox(height: 10),
//               //     ElevatedButton(
//               //       onPressed: () {
//               //         if (viewmodel.validateAndSave()) {
//               //           ScaffoldMessenger.of(context).showSnackBar(
//               //             SnackBar(
//               //               content: Text(
//               //                 'You entered title ${viewmodel.todo.title}!',
//               //               ),
//               //             ),
//               //           );
//               //         }
//               //       },
//               //       child: Text('Submit'),
//               //     ),
//               //   ],
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );