import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class DayOfWeek {
  final String name;
  final int ordinal;

  DayOfWeek(this.name, this.ordinal);

  DateTime thisWeekDateTime() {
    DateTime current =  DateTime.now();
    int daysInBetween;
    if (ordinal > current.weekday)
      daysInBetween = ordinal - current.weekday;
    else
      daysInBetween = DateTime.daysPerWeek - current.weekday + ordinal;
    return current.add(Duration(days: daysInBetween));
  }
}