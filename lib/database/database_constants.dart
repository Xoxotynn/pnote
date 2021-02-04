const String kNotesTable = 'Notes';

enum Column {
  id,
  date,
  mood,
  wakeupTime,
  sleepTime,
  noteText,
  sleepLength,
}

extension ColumnExtension on Column {
  static const columnNames = {
    Column.id: 'id',
    Column.date: 'date',
    Column.mood: 'mood',
    Column.wakeupTime: 'wakeup_time',
    Column.sleepTime: 'sleep_time',
    Column.noteText: 'note_text',
    Column.sleepLength: 'sleep_length',
  };

  String get name => columnNames[this];
}

final kColumnNamesList = ColumnExtension.columnNames.values.toList();

final String kCreateNotesTableQuery = "CREATE TABLE $kNotesTable ("
    "${Column.id.name} INTEGER PRIMARY KEY,"
    "${Column.mood.name} INTEGER,"
    "${Column.date.name} TEXT,"
    "${Column.wakeupTime.name} TEXT,"
    "${Column.sleepTime.name} TEXT,"
    "${Column.sleepLength.name} INTEGER,"
    "${Column.noteText.name} TEXT"
    ")";
