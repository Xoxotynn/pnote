import 'package:flutter/material.dart';
import 'package:pnote/shared/constants.dart';

class TextCard extends StatelessWidget {
  final String text;
  final String title;
  final Function onTap;

  TextCard({
    this.text = 'Not set',
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitleWidget(),
        GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 4,
            shape: Dimension.medium.superellipse,
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
          ),
        ),
      ],
    );
  }

  Widget _buildTitleWidget() {
    if (title == null) {
      return SizedBox();
    } else {
      return Text(
        title,
        maxLines: 1,
        style: TextStyle(fontSize: 20),
      );
    }
  }
}
