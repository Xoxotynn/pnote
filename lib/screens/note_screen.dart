import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pnote/bloc/note.dart';
import 'package:pnote/bloc/notes_bloc.dart';
import 'package:pnote/shared/constants.dart';
import 'package:pnote/shared/utils.dart';
import 'package:pnote/ui_components/bottom_sheet.dart';
import 'package:pnote/ui_components/default_button.dart';
import 'package:pnote/ui_components/text_card.dart';
import 'package:pnote/ui_components/note_form/mood_carousel_slider.dart';
import 'package:pnote/ui_components/note_form/note_text_field.dart';
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

    //TODO Refactor and deconstruct this class with smaller components
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
              SizedBox(
                height: 16,
              ),
              //TODO Implement Date Pickers and Sleep Length Picker
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        'Wake Up',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          buildWakeupTimePicker(context, notesBloc);
                        },
                        child: TextCard(
                          text: note.getWakeupTimeString(),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Sleep',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          buildSleepTimePicker(context, notesBloc);
                        },
                        child: TextCard(
                          text: note.getSleepTimeString(),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          buildSleepLengthPicker(context, notesBloc);
                        },
                        child: TextCard(
                          text: note.getSleepLengthString(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 24,
                ),
                child: NoteTextField(
                  noteTextController: noteTextController,
                  onChanged: (value) {
                    note.noteText = value.trim();
                    _updateNote(notesBloc);
                  },
                ),
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

  buildWakeupTimePicker(BuildContext context, NotesBloc notesBloc) {
    buildBottomSheet(
      context: context,
      title: 'Wake Up Time',
      onComplete: () {
        setState(() {});
        _updateNote(notesBloc);
        Navigator.pop(context);
      },
      child: CupertinoDatePicker(
        initialDateTime: note.wakeupTime,
        minuteInterval: kDefaultMinuteInterval,
        maximumDate: note.sleepTime,
        onDateTimeChanged: (picked) {
          if (picked != null && picked != note.wakeupTime) {
            note.wakeupTime = picked;

            if (_differentDays(picked, note.date)) {
              note.date = picked;
            }
          }
        },
      ),
    );
  }

  bool _differentDays(DateTime date1, DateTime date2) {
    return date1.day != date2.day ||
        date1.month != date2.month ||
        date1.year != date2.year;
  }

  buildSleepTimePicker(BuildContext context, NotesBloc notesBloc) {
    buildBottomSheet(
      context: context,
      title: 'Sleep Time',
      onComplete: () {
        setState(() {});
        _updateNote(notesBloc);
        Navigator.pop(context);
      },
      child: CupertinoDatePicker(
        initialDateTime: note.sleepTime,
        minuteInterval: kDefaultMinuteInterval,
        minimumDate: note.wakeupTime,
        onDateTimeChanged: (picked) {
          if (picked != null && picked != note.sleepTime) {
            note.sleepTime = picked;
          }
        },
      ),
    );
  }

  buildSleepLengthPicker(BuildContext context, NotesBloc notesBloc) {
    buildBottomSheet(
      context: context,
      title: 'Sleep Length',
      onComplete: () {
        setState(() {});
        _updateNote(notesBloc);
        Navigator.pop(context);
      },
      child: CupertinoPicker.builder(
        itemExtent: 32,
        childCount: 25,
        scrollController:
            FixedExtentScrollController(initialItem: note.sleepLength),
        onSelectedItemChanged: (value) => note.sleepLength = value,
        itemBuilder: (context, index) {
          return Center(
            child: Text(index.toString()),
          );
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      toolbarHeight: 64,
      title: Text(
        note.getDateString(),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(CupertinoIcons.arrow_down_to_line),
          color: Colors.white,
          iconSize: 32,
          onPressed: () {},
        ),
      ],
    );
  }

  bool _isNewNote() {
    return widget.note == null;
  }

  void _updateNote(NotesBloc notesBloc) async {
    if (await noteAddedToDatabase(note)) {
      notesBloc.update(note);
    } else {
      int id = await notesBloc.add(note);
      note.id = id;
    }
  }
}
