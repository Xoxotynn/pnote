import 'package:flutter/material.dart';

class MoodImage extends StatelessWidget {
  final int mood;
  final double size;

  MoodImage({@required this.mood, @required this.size});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/mood_icons/mood$mood.png',
      height: size,
      width: size,
    );
  }
}
