import 'package:pnote/database/database_constants.dart';
import 'package:pnote/shared/constants.dart';

/// Input data string pattern:
/// 'dayOfMonth month mood' - meta data
/// 'wakeup time[00:00] note text...'
/// 'note text...'
/// 'sleep time[00:00] note text...'
/// 'sleep length'
///
/// Example:
/// '13 января 3'
/// '08:00 Lorem ipsum dolor sit amet'
/// '''consectetur adipiscing elit, sed do eiusmod tempor incididunt
/// ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
/// nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo'''
/// '23:00 Duis aute irure dolor in reprehenderit'
/// '8'

const stringNote = StringNoteCodec();

class StringNoteCodec {
  const StringNoteCodec();

  Map<String, dynamic> decode(String data) {
    return Map.fromIterables(kColumnNamesList, _getDataValues(data));
  }

  String encode(Map<String, dynamic> data) {
    DateTime date = data[Column.date.name];
    int day = date.day;
    String monthName = _getMonthName(date);
    int mood = data[Column.mood.name];
    String noteText = data[Column.noteText.name];
    int sleepLength = data[Column.sleepLength.name];

    return '$day $monthName $mood\n'
        '$noteText\n'
        '$sleepLength';
  }

  String _getMonthName(DateTime date) {
    return months.keys.toList()[date.month - 1];
  }

  List<dynamic> _getDataValues(String data) {
    DateTime wakeupTime = _getWakeupDateTime(data);
    List dataValues = <dynamic>[
      null,
      _getDate(data),
      _getMood(data),
      wakeupTime,
      _getSleepDateTime(data, wakeupTime),
      _getNoteText(data),
      _getSleepLength(data)
    ];

    return dataValues;
  }

  DateTime _getDate(String data) {
    List<String> dateStringList = _getDateString(data).split(' ');

    int day = int.parse(dateStringList[0]);
    int month = months[dateStringList[1]];
    int year = DateTime.now().year;

    return DateTime(year, month, day);
  }

  int _getMood(String data) {
    String moodString = _getMoodString(data);
    return int.parse(moodString);
  }

  DateTime _getWakeupDateTime(String data) {
    List<String> wakeupDataList = _getWakeupTimeString(data).split(':');
    int hour = int.parse(wakeupDataList[0]);
    int minute = int.parse(wakeupDataList[1]);
    DateTime currentDate = _getDate(data);

    return DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
      hour,
      minute,
    );
  }

  DateTime _getSleepDateTime(String data, DateTime wakeupDateTime) {
    DateTime sleepTime = _getSleepTime(data);

    return sleepTime.isAfter(wakeupDateTime)
        ? sleepTime
        : sleepTime.add(Duration(days: 1));
  }

  String _getNoteText(String data) {
    int metaDataEndIndex = data.indexOf('\n');
    int noteTextEndIndex = data.lastIndexOf('\n');
    String noteText = data.substring(metaDataEndIndex + 1, noteTextEndIndex);
    return noteText;
  }

  int _getSleepLength(String data) {
    String lengthString = _getSleepLengthString(data);
    return int.parse(lengthString);
  }

  String _getDateString(String data) {
    String firstRow = _getFirstRow(data);
    int dateEndIndex = firstRow.lastIndexOf(' ');
    return firstRow.substring(0, dateEndIndex);
  }

  String _getMoodString(String data) {
    String firstRow = _getFirstRow(data);
    int moodStartIndex = firstRow.lastIndexOf(' ') + 1;
    return firstRow.substring(moodStartIndex);
  }

  String _getFirstRow(String data) {
    int firstRowEndIndex = data.indexOf('\n');
    String firstRow = data.substring(0, firstRowEndIndex);
    return firstRow.trim();
  }

  String _getWakeupTimeString(String data) {
    int noteTextStartIndex = data.indexOf('\n') + 1;
    return data.substring(noteTextStartIndex, noteTextStartIndex + 5);
  }

  DateTime _getSleepTime(String data) {
    List<String> sleepDataList = _getSleepTimeString(data).split(':');
    int hour = int.parse(sleepDataList[0]);
    int minute = int.parse(sleepDataList[1]);
    DateTime currentDate = _getDate(data);

    return DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
      hour,
      minute,
    );
  }

  String _getSleepTimeString(String data) {
    String penultRow = _getPenultRow(data);
    String sleepTimeData = penultRow.substring(0, penultRow.indexOf(' '));
    return sleepTimeData;
  }

  String _getPenultRow(String data) {
    List<String> dataList = data.split('\n');
    String penultRow = dataList[dataList.length - 2];
    return penultRow.trim();
  }

  String _getSleepLengthString(String data) {
    int sleepLengthDataStartIndex = data.lastIndexOf('\n') + 1;
    String sleepLengthData = data.substring(sleepLengthDataStartIndex);
    return sleepLengthData.trim();
  }
}
