import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pnote/bloc/note.dart';
import 'package:pnote/note_string_converter/converter.dart';
import 'package:pnote/shared/constants.dart';
import 'package:pnote/ui_components/dialog_window.dart';
import 'package:pnote/ui_components/snackbar.dart';

void buildExportDialog(BuildContext context, List<Note> notes) {
  String notesString = _encodeNotes(notes);
  buildDialog(
    context: context,
    title: 'Your Notes',
    content: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Text(
        notesString,
        style: TextStyle(fontSize: 16),
      ),
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
          'Copy',
          style: kMainActionTextStyle,
        ),
        onPressed: () {
          _copyToClipboard(context, notesString);
          Navigator.pop(context);
        },
      ),
    ],
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
