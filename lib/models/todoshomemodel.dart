import 'dart:collection';

class Todo {
  int _index = 0;
  DateTime _dateModified;
  String _title = "";
  String _body = "";

  Todo({
    required int index,
    required String title,
    required String body,
    DateTime? dateModified,
  }) : _index = index,
       _dateModified = dateModified ?? DateTime(2025),
       _title = title,
       _body = body;

  int get index => _index;
  set index(int value) {
    _index = value;
  }

  DateTime get dateModified => _dateModified;
  set dateModified(DateTime value) {
    _dateModified = dateModified;
  }

  String get title => _title;
  set title(String value) {
    if (value.isNotEmpty) {
      _title = value;
    }
  }

  String get body => _body;
  set body(String value) {
    _body = value;
  }
}

class HomeModel {
  final List<Todo> _todos = [];
  get todos => _todos;
  // UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);
}

// //   void removeAll() {
// //     _todos.clear();
// //     notifyListeners();
// //   }
// // }

// class HomeModel extends ChangeNotifier {
//   final List<Todo> _todos = [];

//   UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

//   void add() {
//     _todos.add(
//       Todo(
//         index: 0,
//         title: 'My first todo',
//         body: '',
//         dateModified: DateTime(2022, 1, 2, 12, 0, 0),
//       ),
//     );
//     _todos.add(
//       Todo(
//         index: 1,
//         title: 'My second todo',
//         body: '',
//         dateModified: DateTime(2023, 1, 2, 12, 0, 0),
//       ),
//     );
//     _todos.add(
//       Todo(
//         index: 2,
//         title: 'My third todo',
//         body: '',
//         dateModified: DateTime(2024, 1, 2, 12, 0, 0),
//       ),
//     );
//     _todos.add(
//       Todo(
//         index: 3,
//         title: 'My fourth todo',
//         body: '',
//         dateModified: DateTime(2025, 1, 2, 12, 0, 0),
//       ),
//     );
//     notifyListeners();
//   }

//   void removeAll() {
//     _todos.clear();
//     notifyListeners();
//   }
// }
