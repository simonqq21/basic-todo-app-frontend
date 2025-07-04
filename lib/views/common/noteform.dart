import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:go_router/go_router.dart';
import 'package:basic_note_app_frontend/utils/logger.dart';
import 'package:basic_note_app_frontend/views/common.dart';
import 'package:basic_note_app_frontend/data/models/note.dart';

class NotesForm extends StatefulWidget {
  final String mode;
  final GlobalKey<FormState>? formKey;
  final TextEditingController titleController;
  final TextEditingController bodyController;
  final Note note;

  NotesForm({
    super.key,
    this.mode = "create",
    this.formKey,
    required this.titleController,
    required this.bodyController,
    required this.note,
  });

  @override
  NotesFormState createState() => NotesFormState();
}

class NotesFormState extends State<NotesForm> {
  String titleText = "";
  Icon? actionButtonIcon;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Consumer<ViewNoteViewModel>(
    //   builder: (context, viewmodel, child) {
    return Container(
      padding: EdgeInsets.only(top: 25),
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: 1200,
        height: 750,
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("title: ", style: globalTextStyle),
                  SizedBox(
                    width: 600,
                    child: TextFormField(
                      style: globalTextStyle,
                      controller: widget.titleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                      enabled: true,
                      validator: (val) {
                        if (val == null || val.isEmpty || val == "") {
                          return 'Please enter the title.';
                        }
                        return null;
                      },
                      // onSaved: (val) {
                      //   logger.i("ghijkl");
                      //   widget.todo.title = val!;
                      // },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 1200,
                height: 580,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Body:"),
                        SizedBox(height: 20),
                        SizedBox(
                          width: 600,
                          height: 480,
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.top,
                            expands: true,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              labelText: 'Body xyz',
                              border: OutlineInputBorder(),
                            ),
                            controller: widget.bodyController,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Container(
                      color: Colors.blue[300],
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Completed: "),
                              Checkbox(
                                value: widget.note.completed,
                                // tristate: true,
                                // onChanged: (bool? val) {
                                //   // setState(() {});
                                //   widget.completed = val;
                                //   logger.i('$val => ${widget.completed}');
                                // },
                                onChanged: (bool? val) {
                                  setState(() {
                                    widget.note.completed = val ?? false;
                                  });
                                  // widget.completed = val;
                                  // logger.i('$val => ${widget.completed}');
                                  logger.i('$val => ${widget.note.completed}');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SizedBox(height: 10),
              //     ElevatedButton(
              //       onPressed: () {
              //         if (viewmodel.validateAndSave()) {
              //           ScaffoldMessenger.of(context).showSnackBar(
              //             SnackBar(
              //               content: Text(
              //                 'You entered title ${viewmodel.todo.title}!',
              //               ),
              //             ),
              //           );
              //         }
              //       },
              //       child: Text('Submit'),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
    //   },
    // );
  }
}


// Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             // context.pop();
//             context.go('/');
//           },
//           icon: Icon(Icons.arrow_back),
//         ),
//         title: Center(child: Text(titleText)),
//       ),
//       body: Container(
//         padding: EdgeInsets.only(top: 25),
//         alignment: Alignment.topCenter,
//         child: SizedBox(
//           width: 1200,
//           height: 750,
//           child: Form(
//             key: widget.formKey,
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("title: ", style: globalTextStyle),
//                     SizedBox(
//                       width: 600,
//                       child: TextFormField(
//                         style: globalTextStyle,
//                         controller: widget.titleController,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'Title',
//                         ),
//                         enabled: true,
//                         validator: (val) {
//                           if (val == null || val.isEmpty || val == "") {
//                             return 'Please enter the title.';
//                           }
//                           return null;
//                         },
//                         // onSaved: (val) {
//                         //   logger.i("ghijkl");
//                         //   viewmodel.todo.title = val!;
//                         // },
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 SizedBox(
//                   width: 1200,
//                   height: 580,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Body:"),
//                           SizedBox(height: 20),
//                           SizedBox(
//                             width: 600,
//                             height: 480,
//                             child: TextFormField(
//                               textAlignVertical: TextAlignVertical.top,
//                               expands: true,
//                               maxLines: null,
//                               keyboardType: TextInputType.multiline,
//                               decoration: InputDecoration(
//                                 labelText: 'Body xyz',
//                                 border: OutlineInputBorder(),
//                               ),
//                               controller: widget.bodyController,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(width: 20),
//                       Container(
//                         color: Colors.blue[300],
//                         child: Column(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text("Completed: "),
//                                 Checkbox(
//                                   value: widget.note?.completed,
//                                   // tristate: true,
//                                   // onChanged: (bool? val) {
//                                   //   // setState(() {});
//                                   //   viewmodel.completed = val;
//                                   //   logger.i('$val => ${viewmodel.completed}');
//                                   // },
//                                   onChanged: (bool? val) {
//                                     setState(() {
//                                       widget.note?.completed = val ?? false;
//                                     });
//                                     // viewmodel.completed = val;
//                                     // logger.i('$val => ${viewmodel.completed}');
//                                     logger.i(
//                                       '$val => ${widget.note?.completed}',
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),

//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.center,
//                 //   children: [
//                 //     SizedBox(height: 10),
//                 //     ElevatedButton(
//                 //       onPressed: () {
//                 //         if (viewmodel.validateAndSave()) {
//                 //           ScaffoldMessenger.of(context).showSnackBar(
//                 //             SnackBar(
//                 //               content: Text(
//                 //                 'You entered title ${viewmodel.todo.title}!',
//                 //               ),
//                 //             ),
//                 //           );
//                 //         }
//                 //       },
//                 //       child: Text('Submit'),
//                 //     ),
//                 //   ],
//                 // ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: widget.onPressed,
//         tooltip: "Save note",
//         child: actionButtonIcon,
//       ),
//     );