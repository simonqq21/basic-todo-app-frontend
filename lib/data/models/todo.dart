// ignore_for_file: unnecessary_getters_setters

class Todo {
  int _id = 0;
  DateTime _dateModified;
  String _title = "";
  String _body = "";
  String _writtenBy = "";
  bool _completed = false;

  Todo({
    required String title,
    required String body,
    DateTime? dateModified,
    String? writtenBy,
    bool? completed,
    int? id,
  }) : _id = id ?? -1,
       _title = title,
       _body = body,
       _dateModified = dateModified ?? DateTime(2025),
       _writtenBy = writtenBy ?? "default",
       _completed = completed ?? false;

  factory Todo.fromJSON(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      dateModified: DateTime.fromMillisecondsSinceEpoch(
        int.parse(json['updated_at_ts']),
      ),
      writtenBy: json['written_by'] as String,
      completed: json['completed'] as bool,
    );
  }

  int get id => _id;
  set id(int value) {
    _id = value;
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

  bool get completed => _completed;
  String get completedString {
    // return _completed? "Yes" : "No";
    if (_completed) {
      return "Yes";
    } else {
      return "No";
    }
  }

  set completed(bool val) {
    _completed = val;
  }

  String get writtenBy => _writtenBy;
  set writtenBy(String val) {
    _writtenBy = val;
  }

  String get body => _body;
  set body(String value) {
    _body = value;
  }
}
