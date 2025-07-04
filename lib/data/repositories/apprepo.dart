import 'package:basic_note_app_frontend/data/services/dbservice.dart';
import 'package:basic_note_app_frontend/utils/result.dart';
import '../models/note.dart';
import '../../utils/logger.dart';
export '../models/note.dart';
import 'package:http/http.dart' as http;

class AppRepo {
  NoteDBService noteDbService = NoteDBService();

  // load notes paginated
  Future<Result<List<Note>>> loadNotes(int? page, int? limit) async {
    page = page ?? 1;
    limit = limit ?? 10;
    Result result = await noteDbService.getNotesPaginated(
      http.Client(),
      page: page,
      limit: limit,
    );
    if (result is Ok) {
      return Result.ok(result.value["notes"]);
    } else {
      return Result.error(Exception("Error getting notes from db."));
    }
  }

  // load note
  Future<Result<Note>> loadNote(int id) async {
    Result result = await noteDbService.getNote(id, http.Client());
    if (result is Ok) {
      Note note = result.value["note"];
      return Result.ok(note);
    } else {
      return Result.error(Exception("Error getting note from db."));
    }
  }

  // create note
  Future<Result> createNote(Note newNote) async {
    Result result = await noteDbService.createNote(newNote, http.Client());
    if (result is Ok) {
      return Result.ok(null);
    } else {
      return Result.error(Exception("Error creating note in db."));
    }
  }

  // edit note
  Future<Result> editNote(int id, Note newNote) async {
    Result result = await noteDbService.updateNote(id, newNote, http.Client());
    if (result is Ok) {
      return Result.ok(null);
    } else {
      return Result.error(Exception("Error updating note in db."));
    }
  }

  // delete a note
  Future<Result> deleteNote(int id) async {
    Result result = await noteDbService.deleteNote(id, http.Client());
    if (result is Ok) {
      return Result.ok(null);
    } else {
      return Result.error(
        Exception("Error deleting note with id $id from db."),
      );
    }
  }
}
