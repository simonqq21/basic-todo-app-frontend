import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:basic_todo_app_frontend/utils/logger.dart';
import 'package:basic_todo_app_frontend/views/common.dart';
import 'package:basic_todo_app_frontend/viewmodels/createtodoviewmodel.dart';

/// class for viewing a single todo
class SingleTodoPage extends StatefulWidget {
  const SingleTodoPage({super.key});

  @override
  SingleTodoPageState createState() => SingleTodoPageState();
}

class SingleTodoPageState extends State<SingleTodoPage> {
  bool? v1 = false;

  @override
  Widget build(BuildContext context) {
    // logger.i("xyz");
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Single Todo View Edit Page"))),
      body: Consumer<CreateTodoViewModel>(
        builder: (context, viewmodel, child) {
          return Container(
            padding: EdgeInsets.only(top: 25),
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 1200,
              height: 700,
              child: Form(
                key: viewmodel.formKey,
                child: Column(
                  children: [
                    Text("Single Todo View Edit Page"),
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
                              logger.i("abcdef");
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
                      height: 500,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Body"),
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
                                      value: viewmodel.todo.todo!.completed,
                                      // tristate: true,
                                      // onChanged: (bool? val) {
                                      //   // setState(() {});
                                      //   viewmodel.completed = val;
                                      //   logger.i('$val => ${viewmodel.completed}');
                                      // },
                                      onChanged: (bool? val) {
                                        setState(() {
                                          viewmodel.todo.todo!.completed = val;
                                        });
                                        // viewmodel.completed = val;
                                        // logger.i('$val => ${viewmodel.completed}');
                                        logger.i(
                                          '$val => ${viewmodel.todo.todo!.completed}',
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (viewmodel.validateAndSave()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'You entered title ${viewmodel.todo.todo!.title}!',
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text('Submit'),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          // onPressed: () => context.go('/'),
                          onPressed: () {
                            // context.pop();
                            context.go('/');
                          },
                          child: const Text('Go to the home screen'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
