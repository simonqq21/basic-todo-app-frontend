import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
// import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:basic_note_app_frontend/utils/logger.dart';
import 'package:basic_note_app_frontend/data/models/note.dart';
import 'package:basic_note_app_frontend/utils/result.dart';
// import 'package:collection/collection.dart';

class NoteDBService {
  // final String _baseURL = "http://localhost:3000";
  final String _baseURL = dotenv.env["BASE_URL"] ?? "http://localhost:3000";

  // get a single Note
  Future<Result<Map>> getNote(int id, http.Client client) async {
    Note note;
    try {
      final response = await client.get(Uri.parse("$_baseURL/notes/$id"));
      // logger.d("response statuscode = ${response.statusCode}");
      if (response.statusCode == 200) {
        // var x = jsonDecode(response.body)["note"] as Map<String, dynamic>;
        note = Note.fromJSON(
          jsonDecode(response.body)["note"] as Map<String, dynamic>,
        );
        return Result.ok({'note': note});
      } else {
        return Result.error(Exception(response.statusCode));
      }
    } catch (e) {
      logger.e(e);
      throw Exception("Failed to get data.");
    }
  }

  // get multiple Notes paginated
  Future<Result<Map>> getNotesPaginated(
    http.Client client, {
    int? page,
    int? limit,
  }) async {
    page = page ?? 1;
    limit = limit ?? 10;
    List<Note> notes = [];

    try {
      final response = await client.get(
        Uri.parse("$_baseURL/notes/?page=$page&limit=$limit"),
      );
      // logger.d("response statuscode = ${response.statusCode}");

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        body['notes'].forEach((t) {
          notes.add(Note.fromJSON(t as Map<String, dynamic>));
        });
        return Result.ok({'notes': notes, 'count': body['count']});
      } else {
        return Result.error(Exception(response.statusCode));
      }
    } catch (e) {
      logger.e(e);
      throw Exception("Failed to get data.");
    }
  }

  // search for note titles
  Future<Result<Map>> searchNotes(
    String searchString,
    http.Client client, {
    int? page,
    int? limit,
  }) async {
    page = page ?? 1;
    limit = limit ?? 10;
    List<Note> notes = [];

    try {
      final response = await client.get(
        Uri.parse(
          "$_baseURL/notes/?search=$searchString&page=$page&limit=$limit",
        ),
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        body['notes'].forEach((t) {
          notes.add(Note.fromJSON(t as Map<String, dynamic>));
        });
        return Result.ok({'notes': notes, 'count': body['count']});
      } else {
        return Result.error(Exception(response.statusCode));
      }
    } catch (e) {
      logger.e(e);
      throw Exception("Failed to get data.");
    }
  }

  // post a single Note
  Future<Result<Map>> createNote(
    // String title,
    // String body,
    // DateTime datecreated,
    // String writtenBy,
    Note newNote,
    http.Client client,
  ) async {
    try {
      final response = await client.post(
        // Uri.parse("$_baseURL/notes"),
        Uri.parse("http://localhost:3000/notes"),

        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'title': newNote.title,
          'body': newNote.body,
          'completed': newNote.completed,
          'createdAt': newNote.createdAt,
          'updatedAt': newNote.updatedAt,
          'written_by': newNote.writtenBy,
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

  // put a single Note
  Future<Result<Map>> updateNote(
    int id,
    Note newNote,
    http.Client client,
  ) async {
    try {
      final response = await client.put(
        Uri.parse("$_baseURL/notes/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'title': newNote.title,
          'body': newNote.body,
          'completed': newNote.completed,
          'createdAt': newNote.createdAt.toIso8601String(),
          'updatedAt': newNote.updatedAt.toIso8601String(),
          'written_by': newNote.writtenBy,
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

  // delete a single Note
  Future<Result<Map>> deleteNote(int id, http.Client client) async {
    try {
      final response = await client.delete(
        Uri.parse("$_baseURL/notes/$id"),
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
