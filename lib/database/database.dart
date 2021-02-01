import 'dart:io';
import 'package:path/path.dart';
import 'package:pnote/database/database_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider databaseProvider = DatabaseProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final String path = await _getDatabasePath();
    return await openDatabase(
      path,
      version: 4,
      onOpen: (db) {},
      onCreate: _createDatabase,
    );
  }

  Future<String> _getDatabasePath() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "NotesDatabase.db");

    return path;
  }

  void _createDatabase(Database db, int version) async {
    await db.execute(kCreateNotesTableQuery);
  }
}
