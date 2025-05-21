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
  Future<Map<String, dynamic>> getTodo() async {
    final response = await http
        .get(
          Uri.parse("http://localhost:3000/todos/87"),
          // Uri.parse("https://jsonplaceholder.typicode.com/albums/2"),
        )
        .catchError((error) {
          logger.e(error);
          return error;
        });
    // $_baseURL/todos/87
    // ignore: unnecessary_brace_in_string_interps
    logger.d("response statuscode = ${response.statusCode}");
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch data.");
    }
    // return {"todo xyz": "2"};
  }

  // get multiple Todos paginated
  Future<List<Map<String, dynamic>>> getTodosPaginated() async {
    return jsonDecode("");
  }
  // post a single Todo

  // put a single Todo

  // delete a single Todo
}
