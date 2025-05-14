// import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:basic_todo_app_frontend/viewmodels/homeviewmodel.dart';
import 'package:basic_todo_app_frontend/views/homeview.dart';

import 'package:basic_todo_app_frontend/views/createtodoview.dart';
import 'package:basic_todo_app_frontend/viewmodels/createtodoviewmodel.dart';

void main() {
  // runApp(MyApp());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => CreateTodoViewModel()),
      ],
      child: const MyApp(),
    ),
    // ChangeNotifierProvider(
    //   create: (context) => HomeViewModel(),
    //   child: const MyApp(),
    // ),
  );
}

final _router = GoRouter(
  routes: <GoRoute>[
    GoRoute(path: '/', builder: (context, state) => HomePage()),
    GoRoute(path: '/todo', builder: (context, state) => SingleTodoPage()),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: "Simonqq21's todo app",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
    );
    //   return MaterialApp(
    //     title: "Simonqq21's todo app",
    //     theme: ThemeData(
    //       colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
    //     ),
    //     // home: HomePage(),
    //     home: SingleTodoPage(),
    //     // routes: <String, WidgetBuilder>{
    //     //   '/todos': (BuildContext context) {
    //     //     return Scaffold(
    //     //       body: Center(
    //     //         child: Text("Hello world from route /todos"),
    //     //       ),
    //     //     );
    //     //   },
    //     //   '/': (BuildContext context) {
    //     //     return Scaffold(
    //     //       body: Center(
    //     //         child: Text("Route /"),
    //     //       ),
    //     //     );
    //     //   },
    //     // },
    //     // initialRoute: '/todos',
    //     // );
    //     // }
    //   );
  }
}

// ----------------------------------------------------------------------

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Simonqq21's todo app",
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         // colorScheme: ColorScheme.light()
//       ),
//       home: const TodoAppHomePage(title: "Simonqq21's todo app"),
//     );
//   }
// }

// class TodoAppHomePage extends StatefulWidget {
//   const TodoAppHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<TodoAppHomePage> createState() => _TodoAppHomePageState();
// }

// class _TodoAppHomePageState extends State<TodoAppHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // backgroundColor: Theme.of(context).colorScheme.onPrimary,
//         backgroundColor: Colors.green.shade400,
//         title: Center(child: Text("Simonqq21's todo app")),
//       ),

//       body: TodoListPage(),

//       bottomNavigationBar: BottomAppBar(
//         color: Colors.blue.shade400,
//         child: Column(
//           children: [
//             Container(height: 30.0, color: Colors.red.shade300),
//             Text("bottom navbar"),
//           ],
//         ),
//       ),
//     );
//   }

//   // int _counter = 0;

//   // void _incrementCounter() {
//   //   setState(() {
//   //     // This call to setState tells the Flutter framework that something has
//   //     // changed in this State, which causes it to rerun the build method below
//   //     // so that the display can reflect the updated values. If we changed
//   //     // _counter without calling setState(), then the build method would not be
//   //     // called again, and so nothing would appear to happen.
//   //     _counter++;
//   //   });
//   // }

//   // @override
//   // Widget build(BuildContext context) {
//   //   // This method is rerun every time setState is called, for instance as done
//   //   // by the _incrementCounter method above.
//   //   //
//   //   // The Flutter framework has been optimized to make rerunning build methods
//   //   // fast, so that you can just rebuild anything that needs updating rather
//   //   // than having to individually change instances of widgets.
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       // TRY THIS: Try changing the color here to a specific color (to
//   //       // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//   //       // change color while the other colors stay the same.
//   //       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//   //       // Here we take the value from the MyHomePage object that was created by
//   //       // the App.build method, and use it to set our appbar title.
//   //       title: Text(widget.title),
//   //     ),
//   //     body: Center(
//   //       // Center is a layout widget. It takes a single child and positions it
//   //       // in the middle of the parent.
//   //       child: Column(
//   //         // Column is also a layout widget. It takes a list of children and
//   //         // arranges them vertically. By default, it sizes itself to fit its
//   //         // children horizontally, and tries to be as tall as its parent.
//   //         //
//   //         // Column has various properties to control how it sizes itself and
//   //         // how it positions its children. Here we use mainAxisAlignment to
//   //         // center the children vertically; the main axis here is the vertical
//   //         // axis because Columns are vertical (the cross axis would be
//   //         // horizontal).
//   //         //
//   //         // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//   //         // action in the IDE, or press "p" in the console), to see the
//   //         // wireframe for each widget.
//   //         mainAxisAlignment: MainAxisAlignment.center,
//   //         children: <Widget>[
//   //           const Text('You have pushed the button this many times:'),
//   //           Text(
//   //             '$_counter',
//   //             style: Theme.of(context).textTheme.headlineMedium,
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //     floatingActionButton: FloatingActionButton(
//   //       onPressed: _incrementCounter,
//   //       tooltip: 'Increment',
//   //       child: const Icon(Icons.add),
//   //     ), // This trailing comma makes auto-formatting nicer for build methods.
//   //   );
//   // }
// }

// class TodoListPage extends StatelessWidget {
//   final List<String> items = List<String>.generate(100, (i) => 'Item $i');

//   @override
//   Widget build(BuildContext context) {
//     // return TodoViewEditPage();
//     return Center(
//       child: Column(
//         // mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text("Centered text inside column"),
//           // Column(children: [Text("a"), Text('b'), Text('c')]),
//           // Column(children: [Text("d"), Text('e'), Text('f')]),
//           // Column(children: [Text("g"), Text('h'), Text('i')]),
//           // ListView(
//           //   children: [Text("item 1000"), Text("Item 2"), Text("item 3")],
//           // ),
//           SizedBox(
//             // alignment: Alignment.center,
//             height: 600,
//             width: 600,
//             child: ListView.builder(
//               itemCount: items.length,
//               prototypeItem: TodoListItem(text: items.first),
//               itemBuilder: (context, index) {
//                 return TodoListItem(text: items[index]);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TodoListItem extends StatelessWidget {
//   final String text;
//   const TodoListItem({super.key, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       width: 50.0,
//       color: Colors.blue,
//       child: Text(text),
//     );
//   }
// }
