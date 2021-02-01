import 'package:flutter/material.dart';

class TopClippedRect extends StatelessWidget {
  final Widget child;
  final double height;

  TopClippedRect({this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(32),
      ),
      child: Container(
        width: double.infinity,
        height: height,
        color: Colors.white,
        child: child,
      ),
    );
  }
}
