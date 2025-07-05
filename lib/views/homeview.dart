import 'package:basic_note_app_frontend/viewmodels/viewnoteviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:basic_note_app_frontend/utils/logger.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:basic_note_app_frontend/viewmodels/homeviewmodel.dart';
import 'package:basic_note_app_frontend/data/models/note.dart';
import 'common.dart';

// class for viewing a list of all todos paginated
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (BuildContext context, HomeViewModel viewmodel, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: Center(child: Text("Simonqq21's notes app yeehaw")),
          ),
          body: Container(
            padding: EdgeInsets.only(top: 25),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                TodoTableHeaderBar(),
                SizedBox(height: 20),
                NoteListView(),
                SizedBox(height: 20),
                PaginationFooter(),
                SizedBox(height: 20),
                // Text("Home page"),
                // ElevatedButton(
                //   onPressed: () => context.go('/todo'),
                //   child: const Text('Go to the todos screen'),
                // ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              logger.d("add todo button pressed");
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const SingleTodoPage()),
              // );
              // context.push('/todo');
              // context.go('/notes/create');
              await context.push('/notes/create');
              await viewmodel.loadNotes();
              logger.i("asdfghjkl");
            },
            tooltip: "create a note",
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

class TodoTableHeaderBar extends StatelessWidget {
  const TodoTableHeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(spacing: 0, children: [ActionButtonBar()]);
  }
}

class ActionButtonBar extends StatefulWidget {
  const ActionButtonBar({super.key});

  @override
  State<ActionButtonBar> createState() => _ActionButtonBarState();
}

class _ActionButtonBarState extends State<ActionButtonBar> {
  var selectVisibility = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewmodel, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: !viewmodel.selectVisibility,
              child: TextButton(
                // style: ButtonStyle(
                //   backgroundColor: WidgetStatePropertyAll<Color>(Colors.black38),
                //   foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
                // ),
                onPressed: () {
                  logger.i("Select pressed");
                  setState(() {
                    viewmodel.selectVisibility = !viewmodel.selectVisibility;
                  });
                  // viewmodel.add();
                },
                child: Text("Select", style: globalTextStyle),
              ),
            ),
            Visibility(
              visible: viewmodel.selectVisibility,
              child: TextButton(
                // style: ButtonStyle(
                //   backgroundColor: WidgetStatePropertyAll<Color>(Colors.black38),
                //   foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
                // ),
                onPressed: () {
                  setState(() {
                    viewmodel.selectVisibility = !viewmodel.selectVisibility;
                    for (Note note in viewmodel.notes) {
                      note.selected = false;
                    }
                  });
                  viewmodel.notifyListeners();
                  logger.i("Unselect pressed");
                },
                child: Text("Unselect", style: globalTextStyle),
              ),
            ),
            Visibility(
              visible: viewmodel.selectVisibility,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    for (Note note in viewmodel.notes) {
                      note.selected = true;
                    }
                  });
                  viewmodel.notifyListeners();
                  logger.i("Select All pressed");
                  // viewmodel.removeAll();
                },
                child: Text("Select All", style: globalTextStyle),
              ),
            ),
            Visibility(
              visible: viewmodel.selectVisibility,
              child: TextButton(
                onPressed: () {
                  logger.i("show delete dialog");
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Confirm delete"),
                        content: Text(
                          "Are you sure you want to delete the selected notes?",
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              logger.i("delete cancelled");
                            },
                            child: Text("Cancel"),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () async {
                              Navigator.of(context).pop();
                              logger.i("delete confirmed");
                              for (var note in viewmodel.notes) {
                                if (note.selected) {
                                  await viewmodel.deleteNote(note.id);
                                }
                                // logger.i('${note.title} ${note.id}');
                              }
                            },
                            child: Text("Delete"),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(Colors.red),
                ),
                child: Text(
                  "Delete",
                  style: globalTextStyle.merge(TextStyle()),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class NoteListView extends StatefulWidget {
  const NoteListView({super.key});

  @override
  State<StatefulWidget> createState() => _NoteListViewState();
}

class _NoteListViewState extends State<NoteListView> {
  final ScrollController verticalSC = ScrollController();
  // var todoItems = [
  //   {
  //     'index': 0,
  //     'title': "My first todo",
  //     'date_modified': DateTime(2022, 1, 2, 12, 0, 0),
  //   },
  //   {
  //     'index': 1,
  //     'title': "My second todo",
  //     'date_modified': DateTime(2023, 1, 2, 12, 0, 0),
  //   },
  //   {
  //     'index': 2,
  //     'title': "My third todo",
  //     'date_modified': DateTime(2024, 1, 2, 12, 0, 0),
  //   },
  //   {
  //     'index': 3,
  //     'title': "My fourth todo",
  //     'date_modified': DateTime(2025, 1, 2, 12, 0, 0),
  //   },
  // ];

  @override
  void initState() {
    HomeViewModel viewmodel = context.read();
    viewmodel.loadNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewmodel, child) {
        return SizedBox(
          width: 1000,
          height: 700,
          child: Center(
            child: Scrollbar(
              controller: verticalSC,
              thumbVisibility: true,
              trackVisibility: true,
              child: ListView.builder(
                controller: verticalSC,
                itemCount: viewmodel.notes.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Colors.lightGreen,
                    child: Center(
                      child: ListTile(
                        // tileColor: Colors.lightGreen, // setting tileColor will make the corners sharp!
                        leading: SizedBox(
                          width: 50,
                          child: Row(
                            children: [
                              Text((viewmodel.notes[index].id).toString()),
                            ],
                          ),
                        ),

                        title: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // SizedBox(width: 10),
                              Text(
                                (viewmodel.notes[index].dateModified)
                                    .toIso8601String(),
                              ),
                              Text(viewmodel.notes[index].title),
                              Text(viewmodel.notes[index].completedString),
                              IconButton(
                                onPressed: () {
                                  context.push(
                                    '/notes/${viewmodel.notes[index].id}',
                                  );
                                },
                                icon: Icon(Icons.edit),
                              ),
                              Visibility(
                                visible: viewmodel.selectVisibility,
                                child: Checkbox(
                                  value: viewmodel.notes[index].selected,
                                  onChanged: (bool? val) {
                                    logger.i(val);
                                    viewmodel.notes[index].selected = val;
                                    viewmodel.notifyListeners();
                                  },
                                ),
                              ),
                              // SizedBox(width: 10),
                            ],
                          ),
                        ),
                        // trailing: Center(child: Row()),
                        // minVerticalPadding: 10.0,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },

      //

      //           );
      //         },)
      //       ));

      //       ),
      //     ),
      //   },
    );
  }
}

class PaginationFooter extends StatelessWidget {
  const PaginationFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: () => {}, icon: Icon(Icons.arrow_back)),
        Text("Page 1 of 10"),

        IconButton(onPressed: () => {}, icon: Icon(Icons.arrow_forward)),
      ],
    );
  }
}
