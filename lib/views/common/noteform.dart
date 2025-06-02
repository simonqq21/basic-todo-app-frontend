import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:basic_todo_app_frontend/utils/logger.dart';
import 'package:basic_todo_app_frontend/views/common.dart';
import 'package:basic_todo_app_frontend/viewmodels/viewnoteviewmodel.dart';

class NotesForm extends StatefulWidget {
  final int id;
  final String title;
  String titleText = "";
  Icon? actionButtonIcon;
  NotesForm({super.key, this.title = "create", this.id = 0}) {
    switch (title) {
      case "create":
        titleText = "Create a Note";
        actionButtonIcon = Icon(Icons.save);
        break;
      case "view":
        titleText = "View a Note";
        actionButtonIcon = Icon(Icons.edit);
        break;
      default:
        titleText = "Edit a Note";
        actionButtonIcon = Icon(Icons.save);
    }
  }

  @override
  NotesFormState createState() => NotesFormState();
}

class NotesFormState extends State<NotesForm> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CreateTodoViewModel>(
      builder: (context, viewmodel, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                // context.pop();
                context.go('/');
              },
              icon: Icon(Icons.arrow_back),
            ),
            title: Center(child: Text(widget.titleText)),
          ),
          body: Container(
            padding: EdgeInsets.only(top: 25),
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 1200,
              height: 700,
              child: Form(
                key: viewmodel.formKey,
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
                            controller: viewmodel.titleController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Title',
                            ),
                            enabled: true,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter the title.';
                              }
                              return null;
                            },
                            // onSaved: (val) {
                            //   logger.i("ghijkl");
                            //   viewmodel.todo.title = val!;
                            // },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 1200,
                      height: 600,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Body"),
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
                                  controller: viewmodel.bodyController,
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
                                      value: viewmodel.todo.completed,
                                      // tristate: true,
                                      // onChanged: (bool? val) {
                                      //   // setState(() {});
                                      //   viewmodel.completed = val;
                                      //   logger.i('$val => ${viewmodel.completed}');
                                      // },
                                      onChanged: (bool? val) {
                                        setState(() {
                                          viewmodel.todo.completed =
                                              val ?? false;
                                        });
                                        // viewmodel.completed = val;
                                        // logger.i('$val => ${viewmodel.completed}');
                                        logger.i(
                                          '$val => ${viewmodel.todo.completed}',
                                        );
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
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              logger.d("save note button pressed");
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const SingleTodoPage()),
              // );
              // context.push('/todo');
              context.go('/todo');
            },
            tooltip: "Save note",
            child: widget.actionButtonIcon,
          ),
        );
      },
    );
  }
}
