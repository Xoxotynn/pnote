import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pnote/shared/constants.dart';

void buildDialog({
  @required BuildContext context,
  String title = '',
  Widget content,
  List<Widget> actions,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        insetPadding: EdgeInsets.all(20),
        contentPadding: EdgeInsets.all(12),
        shape: Dimension.medium.superellipse,
        title: Column(
          children: [
            Text(
              'Your Notes',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            Divider(),
          ],
        ),
        content: content,
        actions: actions,
      );
    },
  );
}
