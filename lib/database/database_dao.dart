import 'package:pnote/database/database.dart';
import 'package:pnote/database/database_constants.dart';
import 'package:pnote/database/note_model.dart';

class DatabaseDao {
  final _databaseProvider = DatabaseProvider.databaseProvider;

  Future<int> addNote(NoteModel newNote) async {
    final db = await _databaseProvider.database;
    final newNoteJson = newNote.toMap();
    int id = await db.insert(kNotesTable, newNoteJson);
    return id;
  }

  Future<int> updateNote(NoteModel newNote) async {
    final db = await _databaseProvider.database;
    final newNoteJson = newNote.toMap();
    int id = await db.update(
      kNotesTable,
      newNoteJson,
      where: "${Column.id.name} = ?",
      whereArgs: [newNote.id],
    );
    return id;
  }

  deleteNote(int id) async {
    final db = await _databaseProvider.database;
    db.delete(kNotesTable, where: "${Column.id.name} = ?", whereArgs: [id]);
  }

  deleteAllNotes() async {
    final db = await _databaseProvider.database;
    db.rawDelete("DELETE FROM $kNotesTable");
  }

  Future<List<NoteModel>> getAllNotes() async {
    List<NoteModel> notes = [];
    var notesListJson = await _getAllNotesListJson();
    if (notesListJson.isNotEmpty) {
      notes =
          notesListJson.map((noteJson) => NoteModel.fromMap(noteJson)).toList();
    }
    return notes;
  }

  Future<NoteModel> getNote(int id) async {
    NoteModel note;
    var notesListJson = await _getNotesListByIdJson(id);
    if (notesListJson.isNotEmpty) {
      var noteJsonData = notesListJson.first;
      note = NoteModel.fromMap(noteJsonData);
    }

    return note;
  }

  Future<List<Map<String, dynamic>>> _getAllNotesListJson() async {
    final db = await _databaseProvider.database;
    var notesJsonList = await db.query(kNotesTable);

    return notesJsonList;
  }

  Future<List<Map<String, dynamic>>> _getNotesListByIdJson(int id) async {
    final db = await _databaseProvider.database;
    var notesJsonList = await db.query(
      kNotesTable,
      where: '${Column.id.name} = ?',
      whereArgs: [id],
    );

    return notesJsonList;
  }
}
