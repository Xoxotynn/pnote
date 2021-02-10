import 'package:pnote/bloc/note.dart';
import 'package:pnote/note_string_converter/string_note_codec.dart';

const Converter converter = Converter();

class Converter {
  const Converter();

  List<Note> generateNotesList(String data) {
    if (data != null) {
      List<String> dataList = _getNoteDataList(data);
      return _convertNoteDataToNotes(dataList);
    } else {
      return [];
    }
  }

  String generateString(List<Note> notes) {
    String result = '';
    if (notes != null) {
      notes.forEach((note) => result += _tryEncode(note));
    }

    return result.trim();
  }

  List<String> _getNoteDataList(String data) {
    return _clearString(data).split('\n\n');
  }

  String _clearString(String data) {
    return data.replaceAll('\r', '');
  }

  List<Note> _convertNoteDataToNotes(List<String> data) {
    return data.map((noteData) => _tryDecode(noteData)).toList();
  }

  Note _tryDecode(String noteData) {
    try {
      return Note.fromString(noteData);
    } catch (e) {
      return null;
    }
  }

  String _tryEncode(Note note) {
    try {
      var noteMap = note.toMap();
      return snCodec.encode(noteMap) + '\r\n\r\n';
    } catch (e) {
      return '';
    }
  }
}
