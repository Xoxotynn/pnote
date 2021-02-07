import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pnote/bloc/note.dart';
import 'package:pnote/bloc/notes_bloc.dart';
import 'package:pnote/ui_components/popup_menu/menu_item_actions.dart';
import 'package:pnote/ui_components/popup_menu/menu_item_content.dart';

List<PopupMenuEntry<MenuItemAction>> buildMenuItems(
  BuildContext context,
  List<Note> notes,
  NotesBloc notesBloc,
) {
  return <PopupMenuEntry<MenuItemAction>>[
    PopupMenuItem(
      value: ImportAction(context: context, notesBloc: notesBloc),
      child: MenuItemContent(
        leadingIcon: CupertinoIcons.arrow_down_to_line,
        title: 'Import',
      ),
    ),
    PopupMenuItem(
      value: ExportAction(context: context, notes: notes),
      child: MenuItemContent(
        leadingIcon: CupertinoIcons.share,
        title: 'Export',
      ),
    ),
    PopupMenuDivider(),
    PopupMenuItem(
      value: ClearAction(context: context, notesBloc: notesBloc),
      child: MenuItemContent(
        destructive: true,
        leadingIcon: CupertinoIcons.delete,
        title: 'Delete All',
      ),
    ),
  ];
}
