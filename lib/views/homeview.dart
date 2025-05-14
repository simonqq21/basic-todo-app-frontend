import 'package:flutter/material.dart';
import 'package:basic_todo_app_frontend/utils/logger.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:basic_todo_app_frontend/viewmodels/homeviewmodel.dart';
import 'common.dart';

// class for viewing a list of all todos paginated
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Simonqq21's todo app yeehaw"))),
      body: Container(
        padding: EdgeInsets.only(top: 25),
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 1000,
          height: 900,
          child: Column(
            children: [
              TodoTableHeaderBar(),
              TodoListView(),
              PaginationFooter(),
              // Text("Home page"),
              // ElevatedButton(
              //   onPressed: () => context.go('/todo'),
              //   child: const Text('Go to the todos screen'),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          logger.d("add todo button pressed");
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const SingleTodoPage()),
          // );
          context.push('/todo');
        },
        tooltip: "create a todo",
        child: const Icon(Icons.add),
      ),
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
  var selectAllBtnVisibility = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, model, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              // style: ButtonStyle(
              //   backgroundColor: WidgetStatePropertyAll<Color>(Colors.black38),
              //   foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
              // ),
              onPressed: () {
                logger.i("Select pressed");
                // setState(() {
                //   selectAllBtnVisibility = !selectAllBtnVisibility;
                // });
                model.add();
              },
              child: Text("Select", style: globalTextStyle),
            ),
            Visibility(
              visible: selectAllBtnVisibility,
              child: TextButton(
                onPressed: () {
                  logger.i("Select All pressed");
                  model.removeAll();
                },
                child: Text("Select All", style: globalTextStyle),
              ),
            ),
          ],
        );
      },
    );
  }
}

// class TodoTableHeader extends StatelessWidget {
//   const TodoTableHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         // Container(width: 100, height: 50, color: Colors.green),
//         // Container(width: 100, height: 50, color: Colors.red),
//         Text("Modified"),
//         Text("Title"),
//         Text("Completed"),
//       ],
//     );
//   }
// }

class TodoListView extends StatefulWidget {
  const TodoListView({super.key});

  @override
  State<StatefulWidget> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
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
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, model, child) {
        // return Flexible(
        //   fit: FlexFit.tight,
        //   child: ListView.builder(
        //     itemCount: model.todos.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       return Padding(
        //         padding: const EdgeInsets.only(bottom: 10),
        //         child: Container(
        //           color: Colors.pink,
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               // Text(todoItems[index]["index"].toString()),
        //               // SizedBox(width: 100),
        //               // Text(todoItems[index]["title"] as String),
        //               Text(model.todos[index].index.toString()),
        //               SizedBox(width: 100),
        //               Text(model.todos[index].title),
        //             ],
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        //   // child: ListView(
        //   //   children: [
        //   //     Text("Todo Listview"),
        //   //     for (var todoItem in todoItems)

        //   //   ],
        //   // ),
        // );

        return SizedBox(
          width: 1000,
          height: 750,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Table(
              // border: TableBorder(
              //   horizontalInside: BorderSide(width: 2, color: Colors.red),
              // ),
              columnWidths: {
                0: FixedColumnWidth(50),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(7),
                3: FlexColumnWidth(1.5),
                4: FixedColumnWidth(80),
              },
              children: [
                TableRow(
                  // decoration: BoxDecoration(color: Colors.green),
                  children: [
                    // Center(
                    //   heightFactor: 2,
                    //   child: Container(
                    //     color: Colors.blue,
                    //     width: 10,
                    //     height: 10,
                    //   ),
                    // ),
                    Container(
                      color: Colors.blue,
                      child: Text(
                        " ",
                        textAlign: TextAlign.center,
                        style: globalTextStyle,
                      ),
                    ),
                    Container(
                      color: Colors.red,
                      child: Text(
                        "Modified",
                        textAlign: TextAlign.center,
                        style: globalTextStyle,
                      ),
                    ),
                    Container(
                      color: Colors.yellow,
                      child: Text(
                        "Title",
                        textAlign: TextAlign.center,
                        style: globalTextStyle,
                      ),
                    ),
                    Container(
                      color: Colors.green,

                      child: Text(
                        "Completed",
                        textAlign: TextAlign.center,
                        style: globalTextStyle,
                      ),
                    ),
                    Container(
                      color: Colors.blue,
                      child: Text(
                        " ",
                        textAlign: TextAlign.center,
                        style: globalTextStyle,
                      ),
                    ),
                  ],
                ),
                for (var todo in model.todos)
                  TableRow(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                    ),
                    children: [
                      Container(
                        height: 60,
                        alignment: Alignment.center,
                        child: Text(
                          todo.index.toString(),
                          textAlign: TextAlign.center,
                          style: globalTextStyle,
                        ),
                      ),
                      Container(
                        height: 60,
                        alignment: Alignment.center,
                        child: Text(
                          todo.dateModified.toString(),
                          textAlign: TextAlign.center,
                          style: globalTextStyle,
                        ),
                      ),
                      Container(
                        height: 60,
                        alignment: Alignment.center,
                        child: Text(
                          todo.title.toString(),
                          style: globalTextStyle,
                        ),
                      ),
                      Container(
                        height: 60,
                        alignment: Alignment.center,
                        child: Text(
                          todo.index.toString(),
                          textAlign: TextAlign.center,
                          style: globalTextStyle,
                        ),
                      ),
                      Container(color: Colors.lightBlue),
                    ],
                  ),

                // TableRow(children: [Text("5"), Text("6"), Text("7"), Text("8")]),
                // TableRow(children: [Text("1"), Text("2"), Text("3"), Text("4")]),
                // TableRow(children: [Text("1"), Text("2"), Text("3"), Text("4")]),
                // TableRow(children: [Text("1"), Text("2"), Text("3"), Text("4")]),
              ],
            ),
          ),
        );
      },
    );
    // return SizedBox(
    //   height: 500,
    //   width: 600,
    //   child: ListView(
    //     children: [
    //       Text("Todo Listview"),
    //       for (var todoItem in todoItems)
    //         ListTile(
    //           leading: Text(todoItem["index"].toString()),
    //           title: Text((todoItem["title"] as String)),
    //         ),
    //     ],
    //   ),
    // );
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
