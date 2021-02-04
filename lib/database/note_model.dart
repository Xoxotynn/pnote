import 'dart:convert';
import 'package:pnote/database/database_constants.dart';

NoteModel noteModelFromJson(String jsonString) {
  final jsonData = json.decode(jsonString);
  return NoteModel.fromMap(jsonData);
}

String noteModelToJson(NoteModel note) {
  final noteMap = note.toMap();
  return json.encode(noteMap);
}

class NoteModel {
  int id;
  int mood;
  String date;
  String wakeupTime;
  String sleepTime;
  int sleepLength;
  String noteText;

  NoteModel({
    this.id,
    this.mood,
    this.date,
    this.wakeupTime,
    this.sleepTime,
    this.sleepLength,
    this.noteText,
  });

  factory NoteModel.fromMap(Map<String, dynamic> json) => new NoteModel(
        id: json[Column.id.name],
        mood: json[Column.mood.name],
        date: json[Column.date.name],
        wakeupTime: json[Column.wakeupTime.name],
        sleepTime: json[Column.sleepTime.name],
        sleepLength: json[Column.sleepLength.name],
        noteText: json[Column.noteText.name],
      );

  Map<String, dynamic> toMap() => {
        Column.id.name: id,
        Column.mood.name: mood,
        Column.date.name: date,
        Column.wakeupTime.name: wakeupTime,
        Column.sleepTime.name: sleepTime,
        Column.sleepLength.name: sleepLength,
        Column.noteText.name: noteText,
      };

  bool equalTo(NoteModel other) {
    return (id == other.id) &&
        (mood == other.mood) &&
        (date == other.date) &&
        (wakeupTime == other.wakeupTime) &&
        (sleepTime == other.sleepTime) &&
        (sleepLength == other.sleepLength) &&
        (noteText == other.noteText);
  }

  @override
  String toString() {
    final String result = '${Column.id.name}: $id,'
        '${Column.mood.name}: $mood,'
        '${Column.date.name}: $date'
        '${Column.wakeupTime.name}: $wakeupTime,'
        '${Column.sleepTime.name}: $sleepTime,'
        '${Column.sleepLength.name}: $sleepLength,'
        '${Column.noteText.name}: $noteText';
    return result;
  }
}
