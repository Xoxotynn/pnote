import 'package:flutter/material.dart';
import 'package:pnote/ui_components/default_button.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

buildBottomSheet({
  @required BuildContext context,
  String title,
  double height,
  Widget child = const SizedBox(),
  Function onComplete,
}) {
  Widget titleWidget = _createTitleWidget(title);

  showModalBottomSheet(
    context: context,
    shape: SuperellipseShape(borderRadius: BorderRadius.circular(40)),
    builder: (BuildContext builder) {
      return Container(
        padding: EdgeInsets.all(20),
        color: Colors.transparent,
        height: height ?? MediaQuery.of(context).size.height / 2,
        child: Column(
          children: [
            titleWidget,
            Divider(),
            Expanded(child: child),
            DefaultButton(
              label: 'Done',
              onPressed: onComplete,
            ),
          ],
        ),
      );
    },
  );
}

Widget _createTitleWidget(String title) {
  Widget titleWidget = SizedBox();
  if (title != null) {
    titleWidget = Text(
      title,
      style: TextStyle(fontSize: 28),
    );
  }

  return titleWidget;
}
