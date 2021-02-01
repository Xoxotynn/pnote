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
        id: json[kIdColumn],
        mood: json[kMoodColumn],
        date: json[kDateColumn],
        wakeupTime: json[kWakeupTimeColumn],
        sleepTime: json[kSleepTimeColumn],
        sleepLength: json[kSleepLengthColumn],
        noteText: json[kNoteTextColumn],
      );

  Map<String, dynamic> toMap() => {
        kIdColumn: id,
        kMoodColumn: mood,
        kDateColumn: date,
        kWakeupTimeColumn: wakeupTime,
        kSleepTimeColumn: sleepTime,
        kSleepLengthColumn: sleepLength,
        kNoteTextColumn: noteText,
      };

  bool equalTo(NoteModel other) {
    bool equalsExpression = (id == other.id) &&
        (mood == other.mood) &&
        (date == other.date) &&
        (wakeupTime == other.wakeupTime) &&
        (sleepTime == other.sleepTime) &&
        (sleepLength == other.sleepLength) &&
        (noteText == other.noteText);

    return equalsExpression;
  }

  @override
  String toString() {
    final String result = '$kIdColumn: $id,'
        ' $kMoodColumn: $mood,'
        ' $kDateColumn: $date'
        ' $kWakeupTimeColumn: $wakeupTime,'
        ' $kSleepTimeColumn: $sleepTime,'
        ' $kSleepLengthColumn: $sleepLength,'
        ' $kNoteTextColumn: $noteText';
    return result;
  }
}
