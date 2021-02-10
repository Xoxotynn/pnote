import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

const kDefaultMinuteInterval = 10;

const int kMaxMood = 4;
const int kMinMood = 0;
const int kDefaultMood = 2;

const int kMinSleepLength = 0;
const int kMaxSleepLength = 24;
const int kDefaultSleepLength = 8;

final DateFormat kDefaultDateFormat = DateFormat.MMMd('en_US');
final DateFormat kDefaultTimeFormat = DateFormat.jm();

enum Dimension {
  small,
  medium,
  big,
}

extension DimensionExtension on Dimension {
  static Map<Dimension, double> _radiusMap = {
    Dimension.small: 24,
    Dimension.medium: 32,
    Dimension.big: 40,
  };

  double get value => _radiusMap[this];
  Radius get radius => Radius.circular(value);
  BorderRadius get borderRadius => BorderRadius.circular(value);
  SuperellipseShape get superellipse =>
      SuperellipseShape(borderRadius: borderRadius);
}

const Map<String, int> months = {
  'января': 1,
  'февраля': 2,
  'марта': 3,
  'апреля': 4,
  'мая': 5,
  'июня': 6,
  'июля': 7,
  'августа': 8,
  'сентября': 9,
  'октября': 10,
  'ноября': 11,
  'декабря': 12,
};
