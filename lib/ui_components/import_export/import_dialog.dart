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
            fontSize: 18,
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
              var notes = Converter.generateList(noteData);
              notes.forEach((note) => notesBloc.add(note));
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
