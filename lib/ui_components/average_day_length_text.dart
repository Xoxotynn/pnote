import 'package:flutter/material.dart';

class AverageDayLengthText extends StatelessWidget {
  final double averageDayLength;
  final double fontSize;

  AverageDayLengthText({@required this.averageDayLength, this.fontSize = 24});

  @override
  Widget build(BuildContext context) {
    return Text(
      'ADL: ${averageDayLength.toStringAsFixed(1)} hours',
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.white,
      ),
    );
  }
}
