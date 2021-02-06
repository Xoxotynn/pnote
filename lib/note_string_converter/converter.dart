import 'package:pnote/bloc/note.dart';

class Converter {
  static List<Note> generateList(String data) {
    data = data.trim();
    List<String> dataList = data.split('\r\n\r\n');
    List<Note> noteList =
        dataList.map((noteData) => Note.fromString(noteData)).toList();

    return noteList;
  }
}
