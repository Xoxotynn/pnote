import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:pnote/bloc/note.dart';
import 'package:pnote/bloc/notes_bloc.dart';
import 'package:pnote/screens/note_screen.dart';
import 'package:pnote/ui_components/notes_list/note_card.dart';
import 'package:provider/provider.dart';

class NoteTile extends StatelessWidget {
  final Note note;

  NoteTile({@required this.note});

  @override
  Widget build(BuildContext context) {
    final NotesBloc notesBloc = Provider.of<NotesBloc>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 22,
      ),
      child: FocusedMenuHolder(
        menuOffset: 4,
        animateMenuItems: true,
        menuWidth: MediaQuery.of(context).size.width * 0.5,
        menuItems: <FocusedMenuItem>[
          FocusedMenuItem(
            title: Text(
              'Delete',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 18,
              ),
            ),
            trailingIcon: Icon(
              CupertinoIcons.delete,
              color: Colors.redAccent,
            ),
            onPressed: () {
              notesBloc.delete(note);
            },
          )
        ],
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) {
                return NoteScreen(
                  note: note,
                );
              },
            ),
          );
        },
        child: NoteCard(note: note),
      ),
    );
  }
}