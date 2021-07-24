import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class Month {
  final String name;
  final int ordinal;

  Month(this.name, this.ordinal);

  @override
  String toString() {
    return name;
  }
}

@immutable
class DayOfWeek {
  final String name;
  final int ordinal;

  DayOfWeek(this.name, this.ordinal);

  DateTime thisWeekDateTime(TimeOfDay time) {
    DateTime current =  DateTime.now();
    int daysInBetween;
    if (ordinal > current.weekday)
      daysInBetween = ordinal - current.weekday;
    else
      daysInBetween = DateTime.daysPerWeek - current.weekday + ordinal;
    return current.add(Duration(days: daysInBetween));
  }
}

int getDayCountForMonthNumber(int year, int month) {
  bool leap = year % 4 == 0;
  switch(month) {
    case DateTime.february:
      return leap ? 29 : 28;
    case DateTime.november:
    case DateTime.april:
    case DateTime.june:
    case DateTime.september:
      return 30;
    default:
      return 31;
  }
}