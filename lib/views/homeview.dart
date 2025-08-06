import 'package:basic_note_app_frontend/viewmodels/viewnoteviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:basic_note_app_frontend/utils/logger.dart';
import 'package:flutter/services.dart';
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
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 100),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                TodoTableHeaderBar(),
                SizedBox(height: 20),
                NoteListView(),
                SizedBox(height: 20),
                PaginationFooter(),
                SizedBox(height: 20),
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 50),
            child: FloatingActionButton(
              onPressed: () async {
                logger.d("add todo button pressed");
                await context.push('/notes/create');
                await viewmodel.loadNotes();
                logger.i("asdfghjkl");
              },
              tooltip: "create a note",
              child: const Icon(Icons.add),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }
}

class TodoTableHeaderBar extends StatelessWidget {
  const TodoTableHeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 0,
      children: [SearchBar(), ActionButtonBar()],
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<HomeViewModel>(
      builder: (context, viewmodel, child) {
        double screenWidth = MediaQuery.of(context).size.width;
        return SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: screenWidth * 0.4,
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54, width: 2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "search a title",
                  ),
                  controller: viewmodel.searchInputController,
                  focusNode: viewmodel.searchInputFocusNode,
                ),
              ),
              IconButton(
                onPressed: () {
                  viewmodel.page = 1;
                  viewmodel.searchNotes();
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ActionButtonBar extends StatelessWidget {
  const ActionButtonBar({super.key});
  final selectVisibility = false;
  // @override
  // State<ActionButtonBar> createState() => _ActionButtonBarState();

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
                //   backgroundColor: WidgetStatePropertyAll<Color>(
                //     Colors.black38,
                //   ),
                //   foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
                // ),
                onPressed: () {
                  logger.i("Select pressed");
                  viewmodel.selectVisibility = !viewmodel.selectVisibility;
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
                  viewmodel.selectVisibility = !viewmodel.selectVisibility;
                  for (Note note in viewmodel.notes) {
                    note.selected = false;
                  }

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
                  for (Note note in viewmodel.notes) {
                    note.selected = true;
                  }

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

// class _ActionButtonBarState extends State<ActionButtonBar> {
//   var selectVisibility = false;
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<HomeViewModel>(
//       builder: (context, viewmodel, child) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Visibility(
//               visible: !viewmodel.selectVisibility,
//               child: TextButton(
//                 // style: ButtonStyle(
//                 //   backgroundColor: WidgetStatePropertyAll<Color>(
//                 //     Colors.black38,
//                 //   ),
//                 //   foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
//                 // ),
//                 onPressed: () {
//                   logger.i("Select pressed");
//                   setState(() {
//                     viewmodel.selectVisibility = !viewmodel.selectVisibility;
//                   });
//                   // viewmodel.add();
//                 },
//                 child: Text("Select", style: globalTextStyle),
//               ),
//             ),
//             Visibility(
//               visible: viewmodel.selectVisibility,
//               child: TextButton(
//                 // style: ButtonStyle(
//                 //   backgroundColor: WidgetStatePropertyAll<Color>(Colors.black38),
//                 //   foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
//                 // ),
//                 onPressed: () {
//                   setState(() {
//                     viewmodel.selectVisibility = !viewmodel.selectVisibility;
//                     for (Note note in viewmodel.notes) {
//                       note.selected = false;
//                     }
//                   });
//                   viewmodel.notifyListeners();
//                   logger.i("Unselect pressed");
//                 },
//                 child: Text("Unselect", style: globalTextStyle),
//               ),
//             ),
//             Visibility(
//               visible: viewmodel.selectVisibility,
//               child: TextButton(
//                 onPressed: () {
//                   setState(() {
//                     for (Note note in viewmodel.notes) {
//                       note.selected = true;
//                     }
//                   });
//                   viewmodel.notifyListeners();
//                   logger.i("Select All pressed");
//                   // viewmodel.removeAll();
//                 },
//                 child: Text("Select All", style: globalTextStyle),
//               ),
//             ),
//             Visibility(
//               visible: viewmodel.selectVisibility,
//               child: TextButton(
//                 onPressed: () {
//                   logger.i("show delete dialog");
//                   showDialog(
//                     context: context,
//                     barrierDismissible: false,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: Text("Confirm delete"),
//                         content: Text(
//                           "Are you sure you want to delete the selected notes?",
//                         ),
//                         actions: <Widget>[
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                               logger.i("delete cancelled");
//                             },
//                             child: Text("Cancel"),
//                           ),
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.red,
//                             ),
//                             onPressed: () async {
//                               Navigator.of(context).pop();
//                               logger.i("delete confirmed");
//                               for (var note in viewmodel.notes) {
//                                 if (note.selected) {
//                                   await viewmodel.deleteNote(note.id);
//                                 }
//                                 // logger.i('${note.title} ${note.id}');
//                               }
//                             },
//                             child: Text("Delete"),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//                 style: ButtonStyle(
//                   backgroundColor: WidgetStatePropertyAll<Color>(Colors.red),
//                 ),
//                 child: Text(
//                   "Delete",
//                   style: globalTextStyle.merge(TextStyle()),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

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
    logger.i("loaded notes after popping context");
    viewmodel.loadNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewmodel, child) {
        return Expanded(
          // width: 1000,
          // height: 660,
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
                                (viewmodel.notes[index].updatedAt)
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
    );
  }
}

class PaginationFooter extends StatelessWidget {
  const PaginationFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (BuildContext context, viewmodel, Widget? child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                if (viewmodel.page > 1) viewmodel.page--;
                viewmodel.updatePageInput();
              },
              icon: Icon(Icons.arrow_back),
            ),
            Text("Page"), SizedBox(width: 10),
            SizedBox(
              width: 50,
              height: 50,
              child: TextField(
                controller: viewmodel.pageInputController,
                focusNode: viewmodel.pageInputFocusNode,
                // maxLength: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 10),
            Text("of"),
            // TextField(
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(
            //     labelText: "input a number",
            //     border: OutlineInputBorder(),
            //   ),
            //   onChanged: (value) {
            //     final number = int.tryParse(value);
            //     if (number != null) {
            //       logger.i('Entered number $number.');
            //     }
            //   },
            // ),
            IconButton(
              onPressed: () {
                viewmodel.page++;
                viewmodel.updatePageInput();
              },
              icon: Icon(Icons.arrow_forward),
            ),
            SizedBox(
              width: 50,
              height: 50,
              child: TextField(
                controller: viewmodel.limitInputController,
                focusNode: viewmodel.limitInputFocusNode,
                // maxLength: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 10),
            Text("items"),
          ],
        );
      },
    );
  }
}
