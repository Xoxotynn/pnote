import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pnote/bloc/note.dart';
import 'package:pnote/bloc/notes_bloc.dart';
import 'package:pnote/note_string_converter/converter.dart';
import 'package:pnote/screens/note_screen.dart';
import 'package:pnote/shared/colors.dart';
import 'package:pnote/shared/constants.dart';
import 'package:pnote/shared/utils.dart';
import 'package:pnote/ui_components/average_day_length_text.dart';
import 'package:pnote/ui_components/mood_image.dart';
import 'package:pnote/ui_components/note_form/note_text_field.dart';
import 'package:pnote/ui_components/notes_list/notes_list.dart';
import 'package:pnote/ui_components/top_clipped_rect.dart';
import 'package:provider/provider.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

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
          appBar: _buildAppBar(context, notes, notesBloc),
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

  Widget _buildAppBar(
    BuildContext context,
    List<Note> notes,
    NotesBloc notesBloc,
  ) {
    return AppBar(
      actions: [
        PopupMenuButton(
          shape: ShapeRadius.small.superellipse,
          padding: EdgeInsets.zero,
          icon: Icon(
            CupertinoIcons.ellipsis_vertical,
            size: 32,
          ),
          onSelected: (value) {
            switch (value) {
              case 0:
                {
                  buildImportDialog(context, notesBloc);
                }
                break;

              case 1:
                {
                  if (notes != null && notes.isNotEmpty)
                    notes.forEach((note) => print(note));
                }
                break;

              case 2:
                {
                  notesBloc.clear();
                }
                break;
            }
          },
          itemBuilder: (context) => <PopupMenuEntry>[
            PopupMenuItem(
              value: 0,
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.arrow_down_to_line,
                    color: Colors.black54,
                    size: 26,
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  Expanded(
                    child: Text(
                      'Import',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 1,
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.share,
                    color: Colors.black54,
                    size: 26,
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  Expanded(
                    child: Text(
                      'Export',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuDivider(),
            PopupMenuItem(
              value: 2,
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.delete,
                    color: Colors.redAccent,
                    size: 26,
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  Expanded(
                    child: Text(
                      'Delete All',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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

  //TODO Redesign widget
  buildImportDialog(BuildContext context, NotesBloc notesBloc) {
    String noteData;
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Your Notes'),
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
}
