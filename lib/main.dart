import 'package:flutter/material.dart';
import 'package:pnote/bloc/notes_bloc.dart';
import 'package:pnote/screens/notes_list_screen.dart';
import 'package:pnote/shared/themes.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(PNoteApp());
}

class PNoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<NotesBloc>(
      create: (context) => NotesBloc(),
      dispose: (context, bloc) => bloc.dispose(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: NotesListScreen(),
      ),
    );
  }
}
