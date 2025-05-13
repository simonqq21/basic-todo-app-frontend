import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:basic_todo_app_frontend/utils/logger.dart';

/// class for viewing a single todo
class SingleTodoPage extends StatefulWidget {
  const SingleTodoPage({super.key});

  _SingleTodoPageState createState() => _SingleTodoPageState();
}

class _SingleTodoPageState extends State<SingleTodoPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";

  @override
  Widget build(BuildContext context) {
    logger.i("xyz");
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Single Todo View Edit Page"))),
      body: Container(
        padding: EdgeInsets.only(top: 25),
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 1000,
          height: 900,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text("Single Todo View Edit Page"),

                TextFormField(
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
                  onSaved: (val) {
                    logger.i("ghijkl");
                    _title = val!;
                  },
                ),
                SizedBox(height: 50),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      logger.i("mnopqr");
                      _formKey.currentState!.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('You entered title $_title!')),
                      );
                    }
                  },
                  child: Text('Submit'),
                ),
                ElevatedButton(
                  // onPressed: () => context.go('/'),
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('Go to the home screen'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
