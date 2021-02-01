import 'dart:async';
import 'package:pnote/bloc/note.dart';
import 'package:pnote/database/database_dao.dart';
import 'package:pnote/database/note_model.dart';

class NotesBloc {
  NotesBloc() {
    _updateNotes();
  }

  final _database = DatabaseDao();
  final _notesController = StreamController<List<Note>>.broadcast();
  get notes => _notesController.stream;

  dispose() {
    _notesController.close();
  }

  Future<int> add(Note newNote) async {
    int id = await _database.addNote(newNote.toNoteModel());
    _updateNotes();
    return id;
  }

  void delete(Note note) {
    _database.deleteNote(note.id);
    _updateNotes();
  }

  void update(Note note) {
    _database.updateNote(note.toNoteModel());
    _updateNotes();
  }

  void clear() {
    _database.deleteAllNotes();
    _updateNotes();
  }

  void _updateNotes() async {
    _notesController.sink.add(await _getAllNotesSorted());
  }

  Future<List<Note>> _getAllNotesSorted() async {
    var notes = await _getAllNotes();
    return _sortedDescendingByDate(notes);
  }

  Future<List<Note>> _getAllNotes() async {
    var noteModels = await _getAllNoteModels();
    return _noteModelsToNotes(noteModels);
  }

  Future<List<NoteModel>> _getAllNoteModels() async {
    return await _database.getAllNotes();
  }

  List<Note> _noteModelsToNotes(List<NoteModel> noteModels) {
    return noteModels.map((noteModel) => Note.fromModel(noteModel)).toList();
  }

  List<Note> _sortedDescendingByDate(List<Note> notes) {
    var sortedNotes = notes.toList();
    sortedNotes.sort((note1, note2) => note2.date.compareTo(note1.date));
    return sortedNotes;
  }
}
