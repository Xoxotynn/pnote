import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pnote/bloc/notes_bloc.dart';
import 'package:pnote/note_string_converter/converter.dart';
import 'package:pnote/shared/constants.dart';
import 'package:pnote/ui_components/dialog_window.dart';
import 'package:pnote/ui_components/note_text_field.dart';

void buildImportDialog(BuildContext context, NotesBloc notesBloc) {
  String noteData;
  buildDialog(
    context: context,
    title: 'Your Notes',
    content: NoteTextField(
      onChanged: (value) => noteData = value,
    ),
    actions: [
      TextButton(
        child: Text(
          'Cancel',
          style: kSecondaryActionTextStyle,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      TextButton(
        child: Text(
          'Import',
          style: kMainActionTextStyle,
        ),
        onPressed: () {
          _decodeAndImportNotes(noteData, notesBloc);
          Navigator.pop(context);
        },
      ),
    ],
  );
}

void _decodeAndImportNotes(String data, NotesBloc notesBloc) {
  var notes = converter.generateNotesList(data);
  notes.forEach((note) => notesBloc.add(note));
}
