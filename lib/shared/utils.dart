import 'package:pnote/bloc/note.dart';
import 'package:pnote/database/database_dao.dart';
import 'package:pnote/shared/constants.dart';

int calculateAverageMood(List<Note> notes) {
  int sumMood = 0;
  int averageMood = kDefaultMood;

  if (notes.isNotEmpty) {
    notes.forEach((note) => sumMood += note.mood);
    averageMood = (sumMood / notes.length).round();
  }

  return averageMood;
}

double calculateAverageDayLength(List<Note> notes) {
  double sumDayLengthInMinutes = 0;
  double averageDayLength = 0;

  if (notes.isNotEmpty) {
    notes.forEach((note) {
      sumDayLengthInMinutes += note.getDayLength().inMinutes;
    });
    averageDayLength = (sumDayLengthInMinutes / notes.length).roundToDouble() /
        Duration.minutesPerHour;
  }

  return averageDayLength;
}

Note getNoteCopy(Note note) {
  return Note.fromModel(note.toNoteModel());
}

Future<bool> noteAddedToDatabase(Note note) async {
  DatabaseDao db = DatabaseDao();
  return _noteExists(note) && await db.getNote(note.id) != null;
}

bool _noteExists(Note note) {
  try {
    return note.id != null;
  } catch (e) {
    return false;
  }
}

String getOneLineString(String text) {
  String copy = _getStringCopy(text);
  return copy.replaceAll('\n', ' ');
}

String _getStringCopy(String text) {
  return text.substring(0, text.length);
}
