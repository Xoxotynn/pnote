import 'package:flutter/material.dart';
import 'package:pnote/bloc/note.dart';
import 'package:pnote/bloc/notes_bloc.dart';
import 'package:pnote/shared/constants.dart';
import 'package:pnote/shared/utils.dart';
import 'package:pnote/ui_components/default_button.dart';
import 'package:pnote/ui_components/note_form/bottom_date_time_picker.dart';
import 'package:pnote/ui_components/note_form/bottom_integer_picker.dart';
import 'package:pnote/ui_components/note_text_field.dart';
import 'package:pnote/ui_components/text_card.dart';
import 'package:pnote/ui_components/note_form/mood_carousel_slider.dart';
import 'package:pnote/ui_components/top_clipped_rect.dart';
import 'package:provider/provider.dart';

class NoteScreen extends StatefulWidget {
  final Note note;

  NoteScreen({this.note});

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  Note note;
  final TextEditingController noteTextController = TextEditingController();

  @override
  void initState() {
    note = _isNewNote() ? Note() : getNoteCopy(widget.note);
    noteTextController.text = note.noteText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final NotesBloc notesBloc = Provider.of<NotesBloc>(context);

    return Scaffold(
      appBar: _buildAppBar(),
      body: TopClippedRect(
        height: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 64),
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MoodCarouselSlider(
                initialMoodPage: note.mood,
                onPageChanged: (value, reason) {
                  note.mood = value;
                  _updateNote(notesBloc);
                },
              ),
              Divider(),
              SizedBox(height: 16),
              _timeValuePickerButtons(context, notesBloc),
              NoteTextField(
                margin: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 24,
                ),
                noteTextController: noteTextController,
                onChanged: (value) {
                  note.noteText = value.trim();
                  _updateNote(notesBloc);
                },
              ),
              DefaultButton(
                label: 'Save',
                onPressed: () {
                  _updateNote(notesBloc);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _timeValuePickerButtons(BuildContext context, NotesBloc notesBloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _wakeupTimePickerButton(context, notesBloc),
        _sleepPickerButtons(context, notesBloc),
      ],
    );
  }

  Widget _wakeupTimePickerButton(BuildContext context, NotesBloc notesBloc) {
    return TextCard(
      title: 'Wake Up',
      text: note.getWakeupTimeString(),
      onTap: () {
        _buildWakeupTimePicker(context, notesBloc);
      },
    );
  }

  Widget _sleepPickerButtons(BuildContext context, NotesBloc notesBloc) {
    return Column(
      children: [
        _sleepTimePickerButton(context, notesBloc),
        _sleepLengthPickerButton(context, notesBloc),
      ],
    );
  }

  Widget _sleepTimePickerButton(BuildContext context, NotesBloc notesBloc) {
    return TextCard(
      title: 'Sleep',
      text: note.getSleepTimeString(),
      onTap: () {
        _buildSleepTimePicker(context, notesBloc);
      },
    );
  }

  Widget _sleepLengthPickerButton(BuildContext context, NotesBloc notesBloc) {
    return TextCard(
      text: note.getSleepLengthString(),
      onTap: () {
        _buildSleepLengthPicker(context, notesBloc);
      },
    );
  }

  void _buildWakeupTimePicker(BuildContext context, NotesBloc notesBloc) {
    buildBottomDateTimePicker(
      context: context,
      title: 'Wake Up Time',
      initialDateTime: note.wakeupTime,
      maxDateTime: note.sleepTime,
      onSelectionComplete: (picked) {
        note.wakeupTime = picked;
        _updateDate(picked);
        _updateNoteAndPop(context, notesBloc);
      },
    );
  }

  void _buildSleepTimePicker(BuildContext context, NotesBloc notesBloc) {
    buildBottomDateTimePicker(
      context: context,
      title: 'Sleep Time',
      initialDateTime: note.sleepTime,
      minDateTime: note.wakeupTime,
      onSelectionComplete: (picked) {
        note.sleepTime = picked;
        _updateNoteAndPop(context, notesBloc);
      },
    );
  }

  void _buildSleepLengthPicker(BuildContext context, NotesBloc notesBloc) {
    buildBottomIntegerPicker(
      context: context,
      title: 'Sleep Length',
      childCount: kMaxSleepLength + 1,
      initialValue: note.sleepLength,
      onSelectionComplete: (picked) {
        note.sleepLength = picked;
        _updateNoteAndPop(context, notesBloc);
      },
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(
        note.getDateString(),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  bool _isNewNote() {
    return widget.note == null;
  }

  void _updateDate(DateTime newDate) {
    if (differentDays(newDate, note.date)) note.date = newDate;
  }

  void _updateNoteAndPop(BuildContext context, NotesBloc notesBloc) {
    _updateNote(notesBloc);
    Navigator.pop(context);
  }

  void _updateNote(NotesBloc notesBloc) async {
    if (await noteAddedToDatabase(note)) {
      notesBloc.update(note);
    } else {
      int id = await notesBloc.add(note);
      note.id = id;
    }
    setState(() {});
  }
}
