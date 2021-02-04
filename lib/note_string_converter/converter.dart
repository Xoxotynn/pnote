import 'package:pnote/bloc/note.dart';
import 'package:pnote/note_string_converter/string_note_codec.dart';
import 'package:pnote/shared/constants.dart';

class Converter {
  static void decode(String data) {
    data = data.trim();
    List<String> dataList = data.split('\n\n');
  }

  static String encode(List<Note> notes) {}
}
