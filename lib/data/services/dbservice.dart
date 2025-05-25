import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../utils/logger.dart';
import "../models/todo.dart";

class TodoDBService {
  // final String _baseURL = "http://localhost:3000";
  final String _baseURL = dotenv.env["BASE_URL"] ?? "http://localhost:3000";

  // get a single Todo
  Future<http.Response> getTodo(int id) async {
    return http
        .get(Uri.parse("$_baseURL/todos/$id"))
        .then((response) {
          logger.d("response statuscode = ${response.statusCode}");
          // logger.d(jsonDecode(response.body));
          return response;
        })
        .catchError((error) {
          logger.e(error);
          throw Exception("Failed to get data.");
        });
  }

  // get multiple Todos paginated
  Future<http.Response> getTodosPaginated({int? page, int? limit}) async {
    page = page ?? 1;
    limit = limit ?? 99;
    return http
        .get(Uri.parse("$_baseURL/todos/?page=$page&limit=$limit"))
        .then((response) {
          logger.d("response statuscode = ${response.statusCode}");
          return response;
        })
        .catchError((error) {
          logger.e(error);
          throw Exception("Failed to get data.");
        });
  }

  // search for todo titles
  Future<http.Response> searchTodos(
    String searchString, {
    int? page,
    int? limit,
  }) async {
    page = page ?? 1;
    limit = limit ?? 99;
    return http
        .get(
          Uri.parse("$_baseURL/todos/?search=$searchString&$page&limit=$limit"),
        )
        .then((response) {
          logger.d("response statuscode = ${response.statusCode}");
          // logger.d(jsonDecode(response.body));
          return response;
        })
        .catchError((error) {
          logger.e(error);
          throw Exception("Failed to get data.");
        });
  }

  // post a single Todo
  Future<http.Response> createTodo(
    String title,
    String body,
    DateTime datecreated,
    String writtenBy,
  ) async {
    return http
        .post(
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
        )
        .then((response) {
          logger.d("response statuscode = ${response.statusCode}");
          // logger.d(jsonDecode(response.body));
          return response;
        })
        .catchError((error) {
          logger.e(error);
          throw Exception("Failed to post data.");
        });
  }

  // put a single Todo
  Future<http.Response> updateTodo(
    int id,
    String title,
    String body,
    DateTime datecreated,
    String writtenBy,
  ) async {
    return http
        .put(
          Uri.parse("$_baseURL/todos/$id"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{'title': title}),
        )
        .then((response) {
          logger.d("response statuscode = ${response.statusCode}");
          return response;
        })
        .catchError((error) {
          logger.e(error);
          throw Exception("Failed to put data.");
        });
  }

  // delete a single Todo
  Future<http.Response> deleteTodo(int id) async {
    return http
        .delete(
          Uri.parse("$_baseURL/todos/$id"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        )
        .then((response) {
          logger.d("response statuscode = ${response.statusCode}");
          return response;
        })
        .catchError((error) {
          logger.e(error);
          throw Exception("Failed to delete data.");
        });
  }
}
