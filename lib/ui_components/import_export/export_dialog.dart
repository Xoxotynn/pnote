import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pnote/bloc/note.dart';
import 'package:pnote/note_string_converter/converter.dart';
import 'package:pnote/shared/colors.dart';
import 'package:pnote/ui_components/snackbar.dart';

//TODO Redesign widget
buildExportDialog(BuildContext context, List<Note> notes) {
  String notesString = _encodeNotes(notes);
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
        content: Text(
          notesString,
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(
              'Copy',
              style: TextStyle(
                color: kBlueAccentColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            onPressed: () {
              _copyToClipboard(context, notesString);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

String _encodeNotes(List<Note> notes) {
  return converter.generateString(notes);
}

void _copyToClipboard(BuildContext context, String data) {
  var clipboardData = ClipboardData(text: data);

  Clipboard.setData(clipboardData).then((_) {
    _showSnackBar(context);
  });
}

void _showSnackBar(BuildContext context) {
  var snackBar = buildSnackBar(
    text: 'Notes copied to clipboard',
    trailingIcon: CupertinoIcons.doc_on_doc,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
