import 'package:flutter/material.dart';

class MenuItemContent extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final bool destructive;

  MenuItemContent({
    this.leadingIcon,
    this.title,
    this.destructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color iconColor = destructive ? Colors.redAccent : Colors.black54;
    final Color titleColor = destructive ? Colors.redAccent : Colors.black87;

    return Row(
      children: [
        Icon(
          leadingIcon,
          color: iconColor,
          size: 26,
        ),
        SizedBox(
          width: 1,
        ),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: titleColor,
            ),
          ),
        ),
      ],
    );
  }
}
