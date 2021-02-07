import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pnote/shared/colors.dart';

class NoteTextField extends StatelessWidget {
  final TextEditingController noteTextController;
  final Function(String value) onChanged;
  final EdgeInsets margin;

  NoteTextField({
    this.noteTextController,
    this.onChanged,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: CupertinoTextField(
        controller: noteTextController,
        onChanged: onChanged,
        placeholder: 'Your note',
        cursorColor: kBlueAccentColor,
        clearButtonMode: OverlayVisibilityMode.editing,
        enableSuggestions: true,
        expands: true,
        maxLines: null,
        minLines: null,
      ),
    );
  }
}
