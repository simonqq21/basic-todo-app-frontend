import 'dart:convert';
// import 'package:http/testing.dart';
@Timeout(Duration(seconds: 9000))
// import 'package:test/test.dart';
import 'package:basic_note_app_frontend/data/models/note.dart';
import 'package:basic_note_app_frontend/utils/result.dart';
import 'package:basic_note_app_frontend/data/services/dbservice.dart';
// import '../data/services/dbservice.dart';
import 'package:basic_note_app_frontend/utils/logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
// import 'package:mocking/main.dart';
import 'dbservice_test.mocks.dart';

@GenerateMocks([http.Client])
void main() async {
  await dotenv.load(fileName: ".env");
  final dbService = NoteDBService();
  Result result;
  Note latestTodo;
  var notes;
  var count;
  int maxCount = 100;
  Note newNote;

  test('Creating a note must succeed with HTTP 201.', () async {
    final client = MockClient();
    // final client = http.Client();
    when(
      client.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
        encoding: anyNamed('encoding'),
      ),
    ).thenAnswer((_) async => http.Response('{}', 201));
    newNote = Note(
      title: "Todo 1",
      body: "This is the first note. It should not be deleted",
      dateModified: DateTime.now(),
      writtenBy: "simonque",
    );
    result = await dbService.createNote(newNote, client);
    expect(result, isA<Ok>());
  });

  test(
    'Getting a note that exists must succeed with HTTP 200 and return the note object.',
    () async {
      final client = MockClient();
      when(client.get(any)).thenAnswer(
        (_) async => http.Response(
          '{"note": {"id": 0, "title": "Flutter is awesome!", "body": "Flutter is easy to learn with good documentation and plenty of features."}}',
          200,
        ),
      );
      int id = 0;
      result = await dbService.getNote(id, client);
      // expect(result, isA<Ok>());
      // // expect((result as Ok).value.containsKey('note'), true);
      // expect((result as Ok).value, containsPair('note', isNotNull));
    },
  );
}

// void main() async {
  // await dotenv.load(fileName: ".env");
  // NoteDBService dbService = NoteDBService();
  // Result result;
  // Note latestTodo;
  // var notes;
  // var count;
  // int maxCount = 100;
  // Note newTodo;

  // test('Creating a note must succeed with HTTP 201.', () async {
  //   result = await dbService.searchTodos("Todo 1");
  //   notes = (result as Ok).value["notes"];
  //   count = (result as Ok).value["count"];
  //   if (count > 1) {
  //     for (int i = 1; i < count; i++) {
  //       await dbService.deleteTodo(notes[i].id);
  //     }
  //   } else if (count <= 0) {
  //     newTodo = Note(
  //       title: "Todo 1",
  //       body: "This is the first note. It should not be deleted",
  //       dateModified: DateTime.now(),
  //       writtenBy: "simonque",
  //     );
  //     result = await dbService.createTodo(newTodo);
  //     expect(result, isA<Ok>());
  //   }
  //   newTodo = Note(
  //     title: "test note ",
  //     body: "test note body text",
  //     writtenBy: "simonque",
  //     dateModified: DateTime.now(),
  //   );
  //   result = await dbService.createTodo(newTodo);
  //   expect(result, isA<Ok>());
  // });

//   test(
//     'Getting a note that exists must succeed with HTTP 200 and return the note object.',
//     () async {
//       int id = 0;
//       try {
//         result = await dbService.searchTodos("Todo 1");
//         id = (result as Ok).value["notes"][0].id;
//         result = await dbService.getTodo(id);
//         expect(result, isA<Ok>());
//         // expect((result as Ok).value.containsKey('note'), true);
//         expect((result as Ok).value, containsPair('note', isNotNull));
//       } catch (e) {
//         logger.e("No note with title 'Todo 1' was found: $e");
//       }
//     },
//   );

//   test(
//     'Getting notes paginated must succeed with HTTP 200 and return the list of note objects paginated.',
//     () async {
//       result = await dbService.getTodosPaginated(page: 1, limit: 12);
//       expect(result, isA<Ok>());
//       expect((result as Ok).value, containsPair('notes', isNotNull));
//       expect((result as Ok).value, containsPair('count', isNotNull));
//       // body = jsonDecode(result.body);
//       // logger.d('body length = ${body["notes"].length}');
//       // expect(result.statusCode, 200);
//     },
//   );

//   test(
//     'Finding notes with a case insensitive title substring must succeed with HTTP 200 and return the list of note objects.',
//     () async {
//       result = await dbService.searchTodos("test", page: 1, limit: 120);
//       expect(result, isA<Ok>());
//       expect((result as Ok).value, containsPair('notes', isNotNull));
//       expect((result as Ok).value, containsPair('count', isNotNull));
//     },
//   );

//   test(
//     'Modifying a note that exists must succeed with HTTP 200, and the object must be modified in the backend.',
//     () async {
//       newTodo = Note(
//         title: "modified title",
//         body: "modified body",
//         dateModified: DateTime.now(),
//         writtenBy: "simonque2",
//       );
//       result = await dbService.getTodosPaginated(page: 1, limit: 2);
//       Note latestTodo = (result as Ok).value["notes"][0];
//       result = await dbService.updateTodo(latestTodo.id, newTodo);
//       expect(result, isA<Ok>());
//       result = await dbService.getTodo(latestTodo.id);
//       latestTodo = (result as Ok).value["note"];
//       expect(result, isA<Ok>());
//       expect(latestTodo.title, equals("modified title"));
//       expect(latestTodo.body, equals("modified body"));
//       expect(latestTodo.writtenBy, equals("simonque2"));
//     },
//   );

//   test(
//     'Deleting a note must succeed with HTTP 200, and the object must not exist in the backend.',
//     () async {
//       result = await dbService.searchTodos("modified");
//       latestTodo = (result as Ok).value["notes"][0];
//       result = await dbService.deleteTodo(latestTodo.id);
//       expect(result, isA<Ok>());

//       result = await dbService.searchTodos("test", page: 1, limit: 120);
//       count = (result as Ok).value["count"];
//       notes = (result as Ok).value["notes"];
//       logger.d('notes length = $count');

//       int deleteCount = count >= maxCount ? count - maxCount : 0;
//       for (var i = 0; i < deleteCount; i++) {
//         try {
//           result = await dbService.deleteTodo(notes[i].id);
//           expect(result, isA<Ok>());
//         } catch (e) {
//           logger.e(e);
//           break;
//         }
//       }

//       result = await dbService.searchTodos("modified", page: 1, limit: 120);
//       count = (result as Ok).value["count"];
//       notes = (result as Ok).value["notes"];
//       logger.d('notes length = $count');
//       deleteCount = count >= maxCount ? count - maxCount : 0;
//       for (var i = 0; i < deleteCount; i++) {
//         try {
//           result = await dbService.deleteTodo(notes[i].id);
//           expect(result, isA<Ok>());
//         } catch (e) {
//           logger.e(e);
//           break;
//         }
//       }
//     },
//   );

//   // test('Getting a note that doesnt exist must return HTTP 404.', () async {});

//   // test('')
// }
