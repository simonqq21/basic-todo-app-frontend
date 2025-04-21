import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Simonqq21's todo app",
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // colorScheme: ColorScheme.light()
      ),
      home: const TodoAppHomePage(title: "Simonqq21's todo app"),
    );
  }
}

class TodoAppHomePage extends StatefulWidget {
  const TodoAppHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<TodoAppHomePage> createState() => _TodoAppHomePageState();
}

class _TodoAppHomePageState extends State<TodoAppHomePage> {
  List<String>? items = List<String>.generate(1000, (i) => 'Item $i');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Colors.green.shade400,
        title: Center(child: Text("Simonqq21's todo app")),
      ),

      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Centered text inside column"),
            // Column(children: [Text("a"), Text('b'), Text('c')]),
            // Column(children: [Text("d"), Text('e'), Text('f')]),
            // Column(children: [Text("g"), Text('h'), Text('i')]),
            // ListView(
            //   children: [Text("item 1000"), Text("Item 2"), Text("item 3")],
            // ),
            Container(
              // alignment: Alignment.center,
              height: 600,
              child: ListView.builder(
                itemCount: items!.length,
                prototypeItem: Container(
                  alignment: Alignment.center,
                  width: 50.0,
                  color: Colors.blue,
                  child: Text(items!.first),
                ),
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    width: 50.0,
                    color: Colors.blue,
                    child: Text(items![index]),
                  );
                },
                // padding: const EdgeInsets.fromLTRB(50, 25, 50, 50),
                // children: [
                //   Container(
                //     alignment: Alignment.center,
                //     width: 50.0,
                //     color: Colors.blue,
                //     child: Text("item 1"),
                //   ),
                //   Container(
                //     alignment: Alignment.center,
                //     width: 50.0,
                //     color: Colors.blue,
                //     child: Text("item 2"),
                //   ),
                //   Container(
                //     alignment: Alignment.center,
                //     width: 50.0,
                //     color: Colors.blue,
                //     child: Text("item 3"),
                //   ),
                // ],
              ),
            ),
            // Flexible(
            //   child: ListView(
            //     padding: const EdgeInsets.fromLTRB(50, 25, 50, 50),
            //     children: [
            //       Container(
            //         width: 50.0,
            //         color: Colors.blue,
            //         child: Text("item 1"),
            //       ),
            //       Container(
            //         width: 50.0,
            //         color: Colors.blue,
            //         child: Text("item 2"),
            //       ),
            //       Container(
            //         width: 50.0,
            //         color: Colors.blue,
            //         child: Text("item 3"),
            //       ),
            //     ],
            //   ),
            // ),

            // SizedBox(
            //   height: 500,
            //   width: 400,
            //   child: ListView(
            //     children: [Text("item 1"), Text("Item 2"), Text("item 3")],
            //   ),
            // ),
          ],
          //   children: [
          //                 // Text("list of todos:"),
          // ListView(
          //   children: [Text("item 1"), Text("Item 2"), Text("item 3")],
          // ),
          //   ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.blue.shade400,
        child: Column(
          children: [
            Container(height: 30.0, color: Colors.red.shade300),
            Text("bottom navbar"),
          ],
        ),
      ),
    );
  }

  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   // This method is rerun every time setState is called, for instance as done
  //   // by the _incrementCounter method above.
  //   //
  //   // The Flutter framework has been optimized to make rerunning build methods
  //   // fast, so that you can just rebuild anything that needs updating rather
  //   // than having to individually change instances of widgets.
  //   return Scaffold(
  //     appBar: AppBar(
  //       // TRY THIS: Try changing the color here to a specific color (to
  //       // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
  //       // change color while the other colors stay the same.
  //       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  //       // Here we take the value from the MyHomePage object that was created by
  //       // the App.build method, and use it to set our appbar title.
  //       title: Text(widget.title),
  //     ),
  //     body: Center(
  //       // Center is a layout widget. It takes a single child and positions it
  //       // in the middle of the parent.
  //       child: Column(
  //         // Column is also a layout widget. It takes a list of children and
  //         // arranges them vertically. By default, it sizes itself to fit its
  //         // children horizontally, and tries to be as tall as its parent.
  //         //
  //         // Column has various properties to control how it sizes itself and
  //         // how it positions its children. Here we use mainAxisAlignment to
  //         // center the children vertically; the main axis here is the vertical
  //         // axis because Columns are vertical (the cross axis would be
  //         // horizontal).
  //         //
  //         // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
  //         // action in the IDE, or press "p" in the console), to see the
  //         // wireframe for each widget.
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           const Text('You have pushed the button this many times:'),
  //           Text(
  //             '$_counter',
  //             style: Theme.of(context).textTheme.headlineMedium,
  //           ),
  //         ],
  //       ),
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: _incrementCounter,
  //       tooltip: 'Increment',
  //       child: const Icon(Icons.add),
  //     ), // This trailing comma makes auto-formatting nicer for build methods.
  //   );
  // }
}

// class TodoListItem extends StatelessWidget {
//   const TodoListItem({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
