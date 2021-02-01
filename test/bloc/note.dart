import 'package:pnote/bloc/note.dart';
import 'package:pnote/shared/constants.dart';
import 'package:pnote/database/note_model.dart';
import 'package:test/test.dart';

void main() {
  DateTime _getDateWithRoundedTime(DateTime date) {
    if (date != null) {
      int remainder = date.minute.remainder(kDefaultMinuteInterval);
      return date.subtract(Duration(minutes: remainder));
    } else {
      return null;
    }
  }

  group('Note Constructors Tests', () {
    test('Empty constructor test', () {
      var note = Note();
      var currentDate = _getDateWithRoundedTime(DateTime.now());
      var noteDateFormatted = kDefaultDateFormat.format(note.date);
      var currentDateFormatted = kDefaultDateFormat.format(currentDate);
      var wakeupTimeFormatted = kDefaultTimeFormat.format(note.wakeupTime);
      var currentTimeFormatted = kDefaultTimeFormat.format(currentDate);
      var currentSleepTime = currentDate.add(Duration(hours: 16));

      expect(note.id == null, true);
      expect(note.mood == kDefaultMood, true);
      expect(noteDateFormatted == currentDateFormatted, true);
      expect(wakeupTimeFormatted == currentTimeFormatted, true);
      expect(note.sleepTime == currentSleepTime, true);
      expect(note.sleepLength == kDefaultSleepLength, true);
      expect(note.noteText == '', true);
    });

    test('fromModel constructor test', () {
      var currentDate = _getDateWithRoundedTime(DateTime.now());
      var noteModel = NoteModel(
        id: 3,
        mood: 2,
        date: currentDate.toString(),
        wakeupTime: currentDate.toString(),
        sleepTime: currentDate.toString(),
        sleepLength: 12,
        noteText: 'noteModel',
      );
      var emptyNote = Note();
      var note = Note.fromModel(noteModel);

      expect(note.toNoteModel().equalTo(noteModel), true);
      expect(emptyNote.toNoteModel().equalTo(noteModel), false);

      expect(note.date == currentDate, true);
    });
  });

  group('Note Method Tests', () {
    var note = Note();
    var currentDate = _getDateWithRoundedTime(DateTime.now());
    var sleepDate = currentDate.add(Duration(hours: 16));
    var nextDayWakeupDate = currentDate.add(Duration(hours: 24));

    test('dateToString test', () {
      expect(
          note.getDateString() == kDefaultDateFormat.format(currentDate), true);
    });

    test('wakeupTimeToString test', () {
      expect(
          note.getWakeupTimeString() == kDefaultTimeFormat.format(currentDate),
          true);
    });

    test('sleepTimeString test', () {
      expect(note.getSleepTimeString() == kDefaultTimeFormat.format(sleepDate),
          true);
    });

    test('getDayLengthInHours test', () {
      expect(
          note.getDayLength().inMinutes ==
              nextDayWakeupDate.difference(currentDate).inMinutes,
          true);
    });
  });
}
