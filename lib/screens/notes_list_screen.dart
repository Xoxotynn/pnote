import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pnote/bloc/note.dart';
import 'package:pnote/bloc/notes_bloc.dart';
import 'package:pnote/screens/note_screen.dart';
import 'package:pnote/shared/constants.dart';
import 'package:pnote/shared/utils.dart';
import 'package:pnote/ui_components/average_day_length_text.dart';
import 'package:pnote/ui_components/mood_image.dart';
import 'package:pnote/ui_components/notes_list/notes_list.dart';
import 'package:pnote/ui_components/top_clipped_rect.dart';
import 'package:provider/provider.dart';

class NotesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NotesBloc notesBloc = Provider.of<NotesBloc>(context);
    int _averageMood = kDefaultMood;
    double _averageDayLength = 0;
    List<Note> notes;

    return StreamBuilder<List<Note>>(
      stream: notesBloc.notes,
      builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
        if (snapshot.hasData) {
          notes = snapshot.data;
          _averageMood = calculateAverageMood(notes);
          _averageDayLength = calculateAverageDayLength(notes);
        }

        return Scaffold(
          appBar: _buildAppBar(notes),
          floatingActionButton: _buildAddFAB(context),
          body: Column(
            children: [
              MoodImage(
                mood: _averageMood,
                size: 150,
              ),
              AverageDayLengthText(
                averageDayLength: _averageDayLength,
              ),
              SizedBox(height: 20),
              Expanded(
                child: TopClippedRect(
                  child: NotesList(
                    notes: notes,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAppBar(List<Note> notes) {
    return AppBar(
      actions: [
        IconButton(
          icon: Icon(Icons.share_rounded),
          iconSize: 32,
          onPressed: () {
            if (notes != null && notes.isNotEmpty)
              notes.forEach((note) => print(note));
          },
        ),
      ],
    );
  }

  Widget _buildAddFAB(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        Icons.add,
        size: 40,
      ),
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) {
            return NoteScreen();
          }),
        );
      },
    );
  }
}
