import 'package:basic_todo_app_frontend/data/services/dbservice.dart';
import 'package:basic_todo_app_frontend/utils/result.dart';
import '../models/note.dart';
import '../../utils/logger.dart';
export '../models/note.dart';
import 'package:http/http.dart' as http;

class AppRepo {
  TodoDBService todoDbService = TodoDBService();

  // load todos paginated
  Future<Result<List<Note>>> loadNotes(int? page, int? limit) async {
    page = page ?? 1;
    limit = limit ?? 10;
    Result result = await todoDbService.getNotesPaginated(
      http.Client(),
      page: page,
      limit: limit,
    );
    if (result is Ok) {
      return Result.ok(result.value["todos"]);
    } else {
      return Result.error(Exception("Error getting todos from db."));
    }
  }

  // load todo
  Future<Result<Note>> loadNote(int id) async {
    Result result = await todoDbService.getNote(id, http.Client());
    if (result is Ok) {
      Note todo = result.value["todo"];
      return Result.ok(todo);
    } else {
      return Result.error(Exception("Error getting todo from db."));
    }
  }

  // create todo
  Future<Result> createNote(Note newTodo) async {
    Result result = await todoDbService.createNote(newTodo, http.Client());
    if (result is Ok) {
      return Result.ok(null);
    } else {
      return Result.error(Exception("Error creating todo in db."));
    }
  }

  // edit todo
  Future<Result> editTodo(int id, Note newTodo) async {
    Result result = await todoDbService.updateNote(id, newTodo, http.Client());
    if (result is Ok) {
      return Result.ok(null);
    } else {
      return Result.error(Exception("Error updating todo in db."));
    }
  }

  // delete a todo
  Future<Result> deleteNote(int id) async {
    Result result = await todoDbService.deleteTodo(id, http.Client());
    if (result is Ok) {
      return Result.ok(null);
    } else {
      return Result.error(
        Exception("Error deleting todo with id $id from db."),
      );
    }
  }
}
