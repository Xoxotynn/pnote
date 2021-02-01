import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pnote/bloc/note.dart';
import 'package:pnote/ui_components/notes_list/note_tile.dart';

class NotesList extends StatelessWidget {
  final List<Note> notes;

  NotesList({@required this.notes});

  @override
  Widget build(BuildContext context) {
    if (notes != null) {
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          bottom: 50,
          top: 24,
        ),
        itemCount: notes.length,
        itemBuilder: (BuildContext context, int index) {
          Note noteItem = notes[index];
          return NoteTile(
            note: noteItem,
          );
        },
      );
    } else {
      return CupertinoActivityIndicator(
        radius: 24,
      );
    }
  }
}
