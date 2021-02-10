import 'package:flutter/cupertino.dart';
import 'package:pnote/bloc/note.dart';
import 'package:pnote/bloc/notes_bloc.dart';
import 'package:pnote/note_string_converter/converter.dart';
import 'package:pnote/ui_components/import_export/export_dialog.dart';
import 'package:pnote/ui_components/import_export/import_dialog.dart';

abstract class MenuItemAction {
  final BuildContext context;

  MenuItemAction(this.context);

  void onSelected();
}

abstract class BlocAction extends MenuItemAction {
  final NotesBloc notesBloc;

  BlocAction(
    BuildContext context,
    this.notesBloc,
  ) : super(context);
}

class ClearAction extends BlocAction {
  ClearAction({
    @required BuildContext context,
    @required NotesBloc notesBloc,
  }) : super(context, notesBloc);

  @override
  void onSelected() => notesBloc.clear();
}

class ImportAction extends BlocAction {
  ImportAction({
    @required BuildContext context,
    @required NotesBloc notesBloc,
  }) : super(context, notesBloc);

  @override
  void onSelected() => buildImportDialog(context, notesBloc);
}

class ExportAction extends MenuItemAction {
  final List<Note> notes;

  ExportAction({
    @required BuildContext context,
    @required this.notes,
  }) : super(context);

  //TODO Implement showing of export dialog
  @override
  void onSelected() {
    buildExportDialog(context, notes);
  }
}
