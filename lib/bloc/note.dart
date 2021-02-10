import 'package:pnote/database/database_constants.dart';
import 'package:pnote/note_string_converter/string_note_codec.dart';
import 'package:pnote/shared/constants.dart';
import 'package:pnote/database/note_model.dart';

class Note {
  int id;
  int mood;
  DateTime date;
  DateTime wakeupTime;
  DateTime sleepTime;
  int sleepLength;
  String noteText = '';

  Note() {
    _initializeEmptyNote();
  }

  Note.fromModel(NoteModel noteModel) {
    _initializeNoteFromNoteModel(noteModel);
  }

  Note.fromString(String data) {
    _initializeNoteFromString(data);
  }

  void _initializeEmptyNote() {
    DateTime currentDate = DateTime.now();
    mood = kDefaultMood;
    date = currentDate;
    wakeupTime = _getDateWithRoundedTime(currentDate);
    sleepTime = _getDateWithRoundedTime(currentDate.add(Duration(hours: 16)));
    sleepLength = kDefaultSleepLength;
  }

  void _initializeNoteFromNoteModel(NoteModel noteModel) {
    id = noteModel.id;
    mood = noteModel.mood;
    date = _getDateFromString(noteModel.date);
    wakeupTime = _getDateFromString(noteModel.wakeupTime);
    sleepTime = _getDateFromString(noteModel.sleepTime);
    sleepLength = noteModel.sleepLength;
    noteText = noteModel.noteText;
  }

  void _initializeNoteFromString(String data) {
    final noteMapData = snCodec.decode(data);
    id = noteMapData[Column.id.name];
    mood = noteMapData[Column.mood.name];
    date = noteMapData[Column.date.name];
    wakeupTime = _getDateWithRoundedTime(noteMapData[Column.wakeupTime.name]);
    sleepTime = _getDateWithRoundedTime(noteMapData[Column.sleepTime.name]);
    sleepLength = noteMapData[Column.sleepLength.name];
    noteText = noteMapData[Column.noteText.name];
  }

  NoteModel toNoteModel() {
    return NoteModel(
      id: id,
      mood: mood,
      date: _getStringDataFromDate(date),
      wakeupTime: _getStringDataFromDate(wakeupTime),
      sleepTime: _getStringDataFromDate(sleepTime),
      sleepLength: sleepLength,
      noteText: noteText,
    );
  }

  String _getStringDataFromDate(DateTime date) {
    return date != null ? date.toString() : null;
  }

  DateTime _getDateFromString(String dateString) {
    DateTime date = dateString != null ? DateTime.tryParse(dateString) : null;
    return _getDateWithRoundedTime(date);
  }

  DateTime _getDateWithRoundedTime(DateTime date) {
    if (date != null) {
      int remainder = date.minute.remainder(kDefaultMinuteInterval);
      return date.subtract(Duration(minutes: remainder));
    } else {
      return null;
    }
  }

  String getDateString() {
    return kDefaultDateFormat.format(date);
  }

  String getWakeupTimeString() {
    return kDefaultTimeFormat.format(wakeupTime);
  }

  String getSleepTimeString() {
    return kDefaultTimeFormat.format(sleepTime);
  }

  String getSleepLengthString() {
    return sleepLength.toString() + ' Hours';
  }

  String getDayLengthString() {
    return getDayLength().inHours.toString() + ' Hours';
  }

  Duration getDayLength() {
    DateTime nexDayStartTime = sleepTime.add(Duration(hours: sleepLength));
    Duration dayDuration = nexDayStartTime.difference(wakeupTime);

    return dayDuration;
  }

  bool hasDifferentDate(Note note) {
    return date.day != note.date.day ||
        date.month != note.date.month ||
        date.year != note.date.year;
  }

  bool equalTo(Note other) {
    bool equalsExpression = (id == other.id) &&
        (mood == other.mood) &&
        (date == other.date) &&
        (wakeupTime == other.wakeupTime) &&
        (sleepTime == other.sleepTime) &&
        (sleepLength == other.sleepLength) &&
        (noteText == other.noteText);

    return equalsExpression;
  }

  Map<String, dynamic> toMap() => {
        Column.id.name: id,
        Column.mood.name: mood,
        Column.date.name: date,
        Column.wakeupTime.name: wakeupTime,
        Column.sleepTime.name: sleepTime,
        Column.sleepLength.name: sleepLength,
        Column.noteText.name: noteText,
      };

  @override
  String toString() {
    final String result = 'id: $id,'
        ' mood: $mood,'
        ' date: ${date.toString()}'
        ' wakeupTime: ${wakeupTime.toString()},'
        ' sleepTime: ${sleepTime.toString()},'
        ' sleepLength: $sleepLength,'
        ' noteText: $noteText';
    return result;
  }
}
