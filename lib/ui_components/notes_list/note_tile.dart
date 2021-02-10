import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:pnote/bloc/note.dart';
import 'package:pnote/bloc/notes_bloc.dart';
import 'package:pnote/note_string_converter/converter.dart';
import 'package:pnote/screens/note_screen.dart';
import 'package:pnote/ui_components/notes_list/note_card.dart';
import 'package:pnote/ui_components/snackbar.dart';
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
        menuWidth: MediaQuery.of(context).size.width * 0.5,
        menuItems: <FocusedMenuItem>[
          FocusedMenuItem(
            title: Text(
              'Copy',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
              ),
            ),
            trailingIcon: Icon(
              CupertinoIcons.doc_on_doc,
              color: Colors.black54,
            ),
            onPressed: () {
              var clipboardData = _getClipboardData([note]);
              _copyToClipboard(context, clipboardData);
            },
          ),
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
          ),
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

  ClipboardData _getClipboardData(List<Note> notes) {
    return ClipboardData(text: converter.generateString(notes));
  }

  void _copyToClipboard(BuildContext context, ClipboardData data) {
    Clipboard.setData(data).then((_) => _showSnackBar(context));
  }

  void _showSnackBar(BuildContext context) {
    var snackBar = buildSnackBar(
      text: 'Note copied to clipboard',
      trailingIcon: CupertinoIcons.doc_on_doc,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
