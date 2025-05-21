import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../utils/logger.dart';
import "../models/todo.dart";

class TodoDBService {
  final String _baseURL = dotenv.env["BASE_URL"] ?? "http://localhost:3000";

  // get a single Todo
  Future<Map<String, dynamic>> getTodo(int id) async {
    final response = await http
        .get(Uri.parse("$_baseURL/todos/$id"))
        .catchError((error) {
          logger.e(error);
          return error;
        });
    logger.d("response statuscode = ${response.statusCode}");
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch data.");
    }
    // return {"todo xyz": "2"};
  }

  // get multiple Todos paginated
  Future<List<Map<String, dynamic>>> getTodosPaginated(int page) async {
    final response = await http.get(Uri.parse("$_baseURL/todos")).catchError((
      error,
    ) {
      logger.e(error);
      return error;
    });
    logger.d("response statuscode = ${response.statusCode}");
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch data.");
    }
  }

  // post a single Todo
  Future<http.Response> createTodo(
    String title,
    String body,
    DateTime datecreated,
    String writtenBy,
  ) async {
    final response = await http.post(
      Uri.parse("$_baseURL/todos"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{'title': title}),
    );
    return response;
  }

  // put a single Todo
  Future<http.Response> updateTodo(
    int id,
    String title,
    String body,
    DateTime datecreated,
    String writtenBy,
  ) async {
    final response = await http.put(
      Uri.parse("$_baseURL/todos/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{'title': title}),
    );
    return response;
  }

  // delete a single Todo
  Future<http.Response> deleteTodo(int id) async {
    final response = await http.delete(
      Uri.parse("$_baseURL/todos/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }
}
