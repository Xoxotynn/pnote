import 'package:flutter/cupertino.dart';
import 'package:pnote/shared/constants.dart';
import 'package:pnote/ui_components/bottom_sheet.dart';

buildBottomDateTimePicker({
  @required BuildContext context,
  String title,
  DateTime initialDateTime,
  DateTime minDateTime,
  DateTime maxDateTime,
  void Function(DateTime) onSelectionComplete,
}) {
  DateTime _selectedDateTime = initialDateTime;

  buildBottomSheet(
    context: context,
    title: title,
    onComplete: () => onSelectionComplete(_selectedDateTime),
    child: CupertinoDatePicker(
      initialDateTime: initialDateTime,
      minuteInterval: kDefaultMinuteInterval,
      minimumDate: minDateTime,
      maximumDate: maxDateTime,
      onDateTimeChanged: (picked) {
        if (pickedDateValid(picked, initialDateTime))
          _selectedDateTime = picked;
      },
    ),
  );
}

bool pickedDateValid(DateTime picked, DateTime initial) {
  return picked != null && picked != initial;
}
