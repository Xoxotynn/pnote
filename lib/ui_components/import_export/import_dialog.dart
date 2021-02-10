import 'package:flutter/cupertino.dart';
import 'package:pnote/bloc/notes_bloc.dart';
import 'package:pnote/note_string_converter/converter.dart';
import 'package:pnote/shared/colors.dart';
import 'package:pnote/ui_components/note_text_field.dart';

//TODO Redesign widget
buildImportDialog(BuildContext context, NotesBloc notesBloc) {
  String noteData;
  showCupertinoDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(
          'Your Notes',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        content: NoteTextField(
          onChanged: (value) => noteData = value,
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(
              'Import',
              style: TextStyle(
                color: kBlueAccentColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            onPressed: () {
              _decodeAndImportNotes(noteData, notesBloc);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

void _decodeAndImportNotes(String data, NotesBloc notesBloc) {
  var notes = converter.generateNotesList(data);
  notes.forEach((note) => notesBloc.add(note));
}
