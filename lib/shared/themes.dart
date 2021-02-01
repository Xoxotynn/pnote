import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pnote/shared/colors.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: kPrimaryGreenColor,
  appBarTheme: lightAppBarTheme,
  floatingActionButtonTheme: lightFABTheme,
  dividerTheme: lightDividerTheme,
);

final AppBarTheme lightAppBarTheme = AppBarTheme(
  color: kPrimaryGreenColor,
  elevation: 0,
  centerTitle: true,
);

final FloatingActionButtonThemeData lightFABTheme =
    FloatingActionButtonThemeData(
  backgroundColor: kPrimaryGreenColor,
  foregroundColor: Colors.white,
);

final DividerThemeData lightDividerTheme = DividerThemeData(
  color: CupertinoColors.systemGrey3,
  thickness: 0.7,
  indent: 32,
  endIndent: 32,
);
