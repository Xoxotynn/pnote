import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pnote/shared/colors.dart';

class NoteTextField extends StatelessWidget {
  final TextEditingController noteTextController;
  final Function(String value) onChanged;

  NoteTextField({
    this.noteTextController,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: noteTextController,
      onChanged: onChanged,
      placeholder: 'Your note',
      cursorColor: kBlueAccentColor,
      clearButtonMode: OverlayVisibilityMode.editing,
      enableSuggestions: true,
      expands: true,
      maxLines: null,
      minLines: null,
    );
  }
}
