import 'package:basic_todo_app_frontend/data/services/dbservice.dart';
import 'package:basic_todo_app_frontend/utils/result.dart';
import '../models/todo.dart';
import '../../utils/logger.dart';
export '../models/todo.dart';

class AppRepo {
  TodoDBService todoDbService = TodoDBService();

  // load todos paginated
  Future<Result<List<Todo>>> loadTodos(int? page, int? limit) async {
    page = page ?? 1;
    limit = limit ?? 10;
    Result result = await todoDbService.getTodosPaginated(
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
  Future<Result<Todo>> loadTodo(int id) async {
    Result result = await todoDbService.getTodo(id);
    if (result is Ok) {
      Todo todo = result.value["todo"];
      return Result.ok(todo);
    } else {
      return Result.error(Exception("Error getting todo from db."));
    }
  }

  // create todo
  Future<Result> createTodo(Todo newTodo) async {
    Result result = await todoDbService.createTodo(newTodo);
    if (result is Ok) {
      return Result.ok(null);
    } else {
      return Result.error(Exception("Error creating todo in db."));
    }
  }

  // edit todo
  Future<Result> editTodo(int id, Todo newTodo) async {
    Result result = await todoDbService.updateTodo(id, newTodo);
    if (result is Ok) {
      return Result.ok(null);
    } else {
      return Result.error(Exception("Error updating todo in db."));
    }
  }

  // delete a todo
  Future<Result> deleteTodo(int id) async {
    Result result = await todoDbService.deleteTodo(id);
    if (result is Ok) {
      return Result.ok(null);
    } else {
      return Result.error(
        Exception("Error deleting todo with id $id from db."),
      );
    }
  }
}
