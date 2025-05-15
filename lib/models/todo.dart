class Todo {
  int _index = 0;
  DateTime _dateModified;
  String _title = "";
  String _body = "";
  bool _completed = false;

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

  bool get completed => _completed;
  set completed(bool val) {
    _completed = val;
  }

  String get body => _body;
  set body(String value) {
    _body = value;
  }
}
