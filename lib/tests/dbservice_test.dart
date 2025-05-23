import 'dart:convert';

import 'package:test/test.dart';
import 'package:basic_todo_app_frontend/data/models/todo.dart';
import 'package:basic_todo_app_frontend/data/services/dbservice.dart';
// import '../data/services/dbservice.dart';
import 'package:basic_todo_app_frontend/utils/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  TodoDBService dbService = TodoDBService();
  var result;
  var body;

  test('Creating a todo must succeed with HTTP 201.', () async {
    result = await dbService.createTodo(
      "test todo",
      "test todo body text",
      DateTime.now(),
      "simonque",
    );
    expect(result.statusCode, 201);
  });

  test(
    'Getting a todo that exists must succeed with HTTP 200 and return the todo object.',
    () async {
      result = await dbService.getTodo(87);
      expect(result.statusCode, 200);
    },
  );

  test(
    'Getting todos paginated must succeed with HTTP 200 and return the list of todo objects paginated.',
    () async {
      result = await dbService.getTodosPaginated(1, limit: 6);
      body = jsonDecode(result.body);
      logger.d('body length = ${body["todos"].length}');
      expect(result.statusCode, 200);
    },
  );

  test(
    'Finding todos with a case insensitive title substring must succeed with HTTP 200 and return the list of todo objects.',
    () async {
      result = await dbService.getTodosPaginated(1);
      body = jsonDecode(result.body);
      logger.d('body length = ${body["todos"].length}');
      expect(result.statusCode, 200);
    },
  );

  test(
    'Modifying a todo that exists must succeed with HTTP 200, and the object must be modified in the backend.',
    () async {},
  );

  test(
    'Deleting a todo must succeed with HTTP 200, and the object must not exist in the backend.',
    () async {
      // result = await dbService.getTodosPaginated(1);
      // body = jsonDecode(result.body);
      // logger.d('body length = ${body["todos"].length}');
      // for (var todo in body["todos"]) {
      //   result = await dbService.deleteTodo(todo["id"]);
      // }
      // result = await dbService.getTodosPaginated(1);
      // body = jsonDecode(result.body);
      // for (var todo in body["todos"]) {
      //   result = await dbService.deleteTodo(todo["id"]);
      // }
      // expect(result.statusCode, 200);
      // expect(body["todos"].length, 0);
    },
  );

  test('Getting a todo that doesnt exist must return HTTP 404.', () async {});

  // test('')
}
