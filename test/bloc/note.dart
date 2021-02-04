import 'package:pnote/bloc/note.dart';
import 'package:pnote/shared/constants.dart';
import 'package:pnote/database/note_model.dart';
import 'package:test/test.dart';

const String data = '''13 января 4
09:00 Проснулся.
11:00 Поход к психотерапевту, было сложно.
15:00 Выпил таблетку.
16:30 Уснул до 8 вечера, проснувшись энергия била через край, фокусироваться тяжело, хотелось бегать, прыгать и веселиться, тревоги почти нет, желания страдать и исчезнуть из этой жизни уже нет. 
23:30 Эффект кончается, я стал спокойнее, уже готов прилечь отдохнуть, не думал, что это пройдет так быстро.
00:30 От энергии почти не осталось и следа, но я не чувствую эту эмоциональную опустошенность и печаль. Чувствуется просто как усталость и спокойствие, немного тревоги все же есть, но не сравнимо с тем что было даже вчера.
03:30 Уснул только к этому времени, спал нормально, даже не просыпался за 9 часов.
9''';

final int currentYear = DateTime.now().year;
const String noteText = '''09:00 Проснулся.
11:00 Поход к психотерапевту, было сложно.
15:00 Выпил таблетку.
16:30 Уснул до 8 вечера, проснувшись энергия била через край, фокусироваться тяжело, хотелось бегать, прыгать и веселиться, тревоги почти нет, желания страдать и исчезнуть из этой жизни уже нет. 
23:30 Эффект кончается, я стал спокойнее, уже готов прилечь отдохнуть, не думал, что это пройдет так быстро.
00:30 От энергии почти не осталось и следа, но я не чувствую эту эмоциональную опустошенность и печаль. Чувствуется просто как усталость и спокойствие, немного тревоги все же есть, но не сравнимо с тем что было даже вчера.
03:30 Уснул только к этому времени, спал нормально, даже не просыпался за 9 часов.''';

final List<dynamic> noteDataValues = [
  null,
  4,
  DateTime(currentYear, 1, 13),
  DateTime(currentYear, 1, 13, 9, 0),
  DateTime(currentYear, 1, 14, 3, 30),
  9,
  noteText,
];

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

    test('Note from string test', () {
      Note expectedNote = Note.fromModel(NoteModel(
        id: null,
        date: DateTime(currentYear, 1, 13).toString(),
        mood: 4,
        wakeupTime: DateTime(currentYear, 1, 13, 9, 0).toString(),
        sleepTime: DateTime(currentYear, 1, 14, 3, 30).toString(),
        sleepLength: 9,
        noteText: noteText,
      ));
      Note actualNote = Note.fromString(data);

      expect(actualNote.equalTo(expectedNote), true);
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

    test('Note to map test', () {
      Note actualNote = Note.fromString(data);

      var noteMap = actualNote.toMap();

      expect(noteMap.values, noteDataValues);
    });
  });
}
