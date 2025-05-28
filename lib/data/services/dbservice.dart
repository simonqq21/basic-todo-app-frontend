import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:basic_todo_app_frontend/utils/logger.dart';
import 'package:basic_todo_app_frontend/data/models/todo.dart';
import 'package:basic_todo_app_frontend/utils/result.dart';
import 'package:collection/collection.dart';

class TodoDBService {
  // final String _baseURL = "http://localhost:3000";
  final String _baseURL = dotenv.env["BASE_URL"] ?? "http://localhost:3000";

  // get a single Todo
  Future<Result<Map>> getTodo(int id) async {
    Todo todo;
    try {
      final response = await http.get(Uri.parse("$_baseURL/todos/$id"));
      // logger.d("response statuscode = ${response.statusCode}");
      if (response.statusCode == 200) {
        var x = jsonDecode(response.body)["todo"] as Map<String, dynamic>;
        todo = Todo.fromJSON(
          jsonDecode(response.body)["todo"] as Map<String, dynamic>,
        );
        return Result.ok({'todo': todo});
      } else {
        return Result.error(Exception(response.statusCode));
      }
    } catch (e) {
      logger.e(e);
      throw Exception("Failed to get data.");
    }
  }

  // get multiple Todos paginated
  Future<Result<Map>> getTodosPaginated({int? page, int? limit}) async {
    page = page ?? 0;
    limit = limit ?? 99;
    List<Todo> todos = [];

    try {
      final response = await http.get(
        Uri.parse("$_baseURL/todos/?page=$page&limit=$limit"),
      );
      // logger.d("response statuscode = ${response.statusCode}");

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        body['todos'].forEach((t) {
          todos.add(Todo.fromJSON(t as Map<String, dynamic>));
        });
        return Result.ok({'todos': todos, 'count': body['count']});
      } else {
        return Result.error(Exception(response.statusCode));
      }
    } catch (e) {
      logger.e(e);
      throw Exception("Failed to get data.");
    }
  }

  // search for todo titles
  Future<Result<Map>> searchTodos(
    String searchString, {
    int? page,
    int? limit,
  }) async {
    page = page ?? 1;
    limit = limit ?? 99;
    List<Todo> todos = [];

    try {
      logger.i(
        "URL = ${Uri.parse("$_baseURL/todos/?search=$searchString&page=$page&limit=$limit")}",
      );
      final response = await http.get(
        Uri.parse(
          "$_baseURL/todos/?search=$searchString&page=$page&limit=$limit",
        ),
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        body['todos'].forEach((t) {
          todos.add(Todo.fromJSON(t as Map<String, dynamic>));
        });
        return Result.ok({'todos': todos, 'count': body['count']});
      } else {
        return Result.error(Exception(response.statusCode));
      }
    } catch (e) {
      logger.e(e);
      throw Exception("Failed to get data.");
    }
  }

  // post a single Todo
  Future<Result<Map>> createTodo(
    String title,
    String body,
    DateTime datecreated,
    String writtenBy,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseURL/todos"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'title': title,
          'body': body,
          // 'dateCreated': datecreated.toIso8601String(),
          'written_by': writtenBy,
        }),
      );
      if (response.statusCode == 201) {
        return Result.ok({});
      } else {
        return Result.error(Exception(response.statusCode));
      }
    } catch (e) {
      logger.e(e);
      throw Exception("Failed to post data.");
    }
  }

  // put a single Todo
  Future<Result<Map>> updateTodo(
    int id,
    String title,
    String body,
    DateTime datecreated,
    String writtenBy,
  ) async {
    try {
      final response = await http.put(
        Uri.parse("$_baseURL/todos/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'title': title,
          'body': body,
          // 'dateCreated': datecreated.toIso8601String(),
          'written_by': writtenBy,
        }),
      );
      if (response.statusCode == 200) {
        return Result.ok({});
      } else {
        return Result.error(Exception(response.statusCode));
      }
    } catch (e) {
      logger.e(e);
      throw Exception("Failed to put data.");
    }
  }

  // delete a single Todo
  Future<Result<Map>> deleteTodo(int id) async {
    try {
      final response = await http.delete(
        Uri.parse("$_baseURL/todos/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return Result.ok({});
      } else {
        return Result.error(Exception(response.statusCode));
      }
    } catch (e) {
      logger.e(e);
      throw Exception("Failed to delete data.");
    }
  }
}
