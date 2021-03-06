import 'package:flutter/material.dart';
import 'package:pnote/bloc/note.dart';
import 'package:pnote/shared/constants.dart';
import 'package:pnote/shared/utils.dart';
import 'package:pnote/ui_components/mood_image.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  NoteCard({@required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: Dimension.small.superellipse,
      child: ListTile(
        leading: MoodImage(
          mood: note.mood,
          size: 60,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(note.getDateString()),
            Text(
              note.getDayLengthString(),
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
        subtitle: Text(
          getOneLineString(note.noteText),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}
