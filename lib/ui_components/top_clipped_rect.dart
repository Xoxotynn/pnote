import 'package:flutter/material.dart';
import 'package:pnote/shared/constants.dart';

class TopClippedRect extends StatelessWidget {
  final Widget child;
  final double height;

  TopClippedRect({this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: ShapeRadius.medium.radius,
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
