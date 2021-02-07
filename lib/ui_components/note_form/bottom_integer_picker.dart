import 'package:flutter/cupertino.dart';
import 'package:pnote/ui_components/bottom_sheet.dart';

buildBottomIntegerPicker({
  @required BuildContext context,
  String title,
  int childCount,
  int initialValue = 0,
  void Function(int) onSelectionComplete,
}) {
  int _selectedLength = initialValue;

  buildBottomSheet(
    context: context,
    title: title,
    onComplete: () => onSelectionComplete(_selectedLength),
    child: CupertinoPicker.builder(
      itemExtent: 32,
      childCount: childCount,
      scrollController: FixedExtentScrollController(initialItem: initialValue),
      onSelectedItemChanged: (value) => _selectedLength = value,
      itemBuilder: (context, index) {
        return Center(
          child: Text(index.toString()),
        );
      },
    ),
  );
}
