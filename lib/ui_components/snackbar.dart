import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pnote/shared/constants.dart';

Widget buildSnackBar({@required String text, IconData trailingIcon}) {
  return SnackBar(
    elevation: 0,
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: Dimension.small.superellipse,
    behavior: SnackBarBehavior.floating,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        Icon(
          trailingIcon,
          color: Colors.white,
        ),
      ],
    ),
  );
}
