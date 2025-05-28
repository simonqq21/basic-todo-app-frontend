import 'dart:convert';
@Timeout(Duration(seconds: 9000))
import 'package:test/test.dart';
import 'package:basic_todo_app_frontend/data/models/todo.dart';
import 'package:basic_todo_app_frontend/utils/result.dart';
import 'package:basic_todo_app_frontend/data/services/dbservice.dart';
// import '../data/services/dbservice.dart';
import 'package:basic_todo_app_frontend/utils/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  TodoDBService dbService = TodoDBService();
  Result result;
  Todo latestTodo;
  var todos;
  var count;
  int maxCount = 100;

  test('Creating a todo must succeed with HTTP 201.', () async {
    result = await dbService.searchTodos("Todo 1");
    todos = (result as Ok).value["todos"];
    count = (result as Ok).value["count"];
    if (count > 1) {
      for (int i = 1; i < count; i++) {
        await dbService.deleteTodo(todos[i].id);
      }
    } else if (count <= 0) {
      result = await dbService.createTodo(
        "Todo 1",
        "This is the first todo. It should not be deleted",
        DateTime.now(),
        "simonque",
      );
      expect(result, isA<Ok>());
    }

    result = await dbService.createTodo(
      "test todo ",
      "test todo body text",
      DateTime.now(),
      "simonque",
    );
    expect(result, isA<Ok>());
  });

  test(
    'Getting a todo that exists must succeed with HTTP 200 and return the todo object.',
    () async {
      int id = 0;
      try {
        result = await dbService.searchTodos("Todo 1");
        id = (result as Ok).value["todos"][0].id;
        result = await dbService.getTodo(id);
        expect(result, isA<Ok>());
        // expect((result as Ok).value.containsKey('todo'), true);
        expect((result as Ok).value, containsPair('todo', isNotNull));
      } catch (e) {
        logger.e("No todo with title 'Todo 1' was found: $e");
      }
    },
  );

  test(
    'Getting todos paginated must succeed with HTTP 200 and return the list of todo objects paginated.',
    () async {
      result = await dbService.getTodosPaginated(page: 1, limit: 12);
      expect(result, isA<Ok>());
      expect((result as Ok).value, containsPair('todos', isNotNull));
      expect((result as Ok).value, containsPair('count', isNotNull));
      // body = jsonDecode(result.body);
      // logger.d('body length = ${body["todos"].length}');
      // expect(result.statusCode, 200);
    },
  );

  test(
    'Finding todos with a case insensitive title substring must succeed with HTTP 200 and return the list of todo objects.',
    () async {
      result = await dbService.searchTodos("test", page: 1, limit: 120);
      expect(result, isA<Ok>());
      expect((result as Ok).value, containsPair('todos', isNotNull));
      expect((result as Ok).value, containsPair('count', isNotNull));
    },
  );

  test(
    'Modifying a todo that exists must succeed with HTTP 200, and the object must be modified in the backend.',
    () async {
      result = await dbService.getTodosPaginated(page: 1, limit: 2);
      Todo latestTodo = (result as Ok).value["todos"][0];
      result = await dbService.updateTodo(
        latestTodo.id,
        "modified title",
        "modified body",
        DateTime.now(),
        "simonque2",
      );
      expect(result, isA<Ok>());
      result = await dbService.getTodo(latestTodo.id);
      latestTodo = (result as Ok).value["todo"];
      expect(result, isA<Ok>());
      expect(latestTodo.title, equals("modified title"));
      expect(latestTodo.body, equals("modified body"));
      expect(latestTodo.writtenBy, equals("simonque2"));
    },
  );

  test(
    'Deleting a todo must succeed with HTTP 200, and the object must not exist in the backend.',
    () async {
      result = await dbService.searchTodos("modified");
      latestTodo = (result as Ok).value["todos"][0];
      result = await dbService.deleteTodo(latestTodo.id);
      expect(result, isA<Ok>());

      result = await dbService.searchTodos("test", page: 1, limit: 120);
      count = (result as Ok).value["count"];
      todos = (result as Ok).value["todos"];
      logger.d('todos length = $count');

      int deleteCount = count >= maxCount ? count - maxCount : 0;
      for (var i = 0; i < deleteCount; i++) {
        try {
          result = await dbService.deleteTodo(todos[i].id);
          expect(result, isA<Ok>());
        } catch (e) {
          logger.e(e);
          break;
        }
      }

      result = await dbService.searchTodos("modified", page: 1, limit: 120);
      count = (result as Ok).value["count"];
      todos = (result as Ok).value["todos"];
      logger.d('todos length = $count');
      deleteCount = count >= maxCount ? count - maxCount : 0;
      for (var i = 0; i < deleteCount; i++) {
        try {
          result = await dbService.deleteTodo(todos[i].id);
          expect(result, isA<Ok>());
        } catch (e) {
          logger.e(e);
          break;
        }
      }
    },
  );

  // test('Getting a todo that doesnt exist must return HTTP 404.', () async {});

  // test('')
}
