import 'package:flutter/material.dart';
import 'package:pnote/shared/constants.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

class TextCard extends StatelessWidget {
  final String text;

  TextCard({this.text = 'Not set'});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: ShapeRadius.medium.superellipse,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: text == 'Not set' ? Colors.redAccent : Colors.black,
          ),
        ),
      ),
    );
  }
}
