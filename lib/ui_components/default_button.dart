import 'package:flutter/cupertino.dart';
import 'package:pnote/shared/colors.dart';

class DefaultButton extends StatelessWidget {
  final Function onPressed;
  final String label;

  DefaultButton({this.onPressed, this.label = ''});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: kBlueAccentColor,
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
