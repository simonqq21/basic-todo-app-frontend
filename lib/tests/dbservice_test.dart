import 'package:test/test.dart';
import 'package:basic_todo_app_frontend/data/models/todo.dart';
import 'package:basic_todo_app_frontend/data/services/dbservice.dart';
import 'package:basic_todo_app_frontend/utils/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  TodoDBService dbService = TodoDBService();

  test('Service must return HTTP 200', () async {
    final result = await dbService.getTodo(87);
    logger.d(result);
    // expect(actual, matcher)
  });
}
