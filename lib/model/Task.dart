import 'package:daily_quest/model/day.dart';
import 'package:daily_quest/utils/constants.dart';
import 'package:daily_quest/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum TaskFrequency {
  Daily,
  Weekly,
  Monthly,
  Yearly,
}

class Task {

  String title;
  String notes = "";
  IconData icon = Icons.title;
  TimeOfDay timeOccurrence;
  DateTime dateTime;

  TaskFrequency taskType;

  //TODO Remove fixed delay in favor of a dynamically computed one
  @deprecated
  Duration _delay;

  bool complete = false;
  bool delayed = false;

  /// Constructs a daily Task
  /// Given a timeOccurrence
  Task.daily(
    this.title,
    this.timeOccurrence,
    [
      this.notes,
      this.icon,
    ]
  ) {
    this.taskType = TaskFrequency.Daily;
  }

  /// Constructs a weekly Task
  /// Given a [weekDay] and a [timeOccurrence]
  Task.weekly(
      this.title,
      this.timeOccurrence,
      DayOfWeek weekDay,
      [
        this.notes,
        this.icon,
      ]
  ) {
    dateTime = weekDay.thisWeekDateTime();
  }

  /// Constructs monthly Task
  /// Given a [dayOfMonth] and a [timeOccurrence]
  Task.monthly(
      this.title,
      this.timeOccurrence,
      int dayOfMonth,
      [
        this.notes,
        this.icon,
      ]
  ) {
    DateTime current = DateTime.now();
    int nextMonth = current.month == DateTime.december ? DateTime.january : current.month + 1;
    dateTime = DateTime(current.year, nextMonth, dayOfMonth);
  }

  /// Constructs a yearly task
  /// Given a [date] (only month and day parameters are used) and a [timeOccurrence]
  Task.yearly(
      this.title,
      this.timeOccurrence,
      DateTime date,
      [
        this.notes,
        this.icon,
      ]
  ) {
    DateTime current = DateTime.now();
    if (current.isAfter(dateTime))
      dateTime = DateTime(current.year + 1, date.month, date.day);
    else
      dateTime = DateTime(current.year, date.month, date.day);
  }

  DateTime nextDateTime() {
    //initialize the date if it's null
    dateTime = dateTime == null ? DateTime.now() : dateTime;

    //Check whether the set DateTime has already passed or not,
    //if it has update the DateTime to the next occurrence, return it and replace the old one
    if (dateTime.isBefore(DateTime.now()))
      dateTime = dateTime.add(_delay);

    return dateTime;
  }

  static DateFormat getFormatter(TaskFrequency frequency) {
    switch(frequency) {
      case TaskFrequency.Daily:
        return Constants.dailyFormat;

      case TaskFrequency.Weekly:
        return Constants.weeklyFormat;

      case TaskFrequency.Monthly:
      case TaskFrequency.Yearly:
      default:
        return Constants.monthlyFormat;
    }
  }

  ///JSON serialization
  ///TODO Rework taking other constructors into account
  Task.fromJsonMap(Map<String, dynamic> json) :
        title = json["title"],
        notes = json["notes"],
        complete = json["complete"],
        icon = new IconData(json["icon"], fontFamily: "MaterialIcons"),
        taskType = UtilFunctions.getFrequencyFromString(json["frequency"]),
        _delay = Duration(seconds: json["delay"]);

  Map<String, dynamic> toJson() => {
    'title': title,
    'notes': notes,
    'complete': complete,
    'icon': icon.codePoint,
    'frequency': taskType.toString(),
    'delay': _delay.inSeconds
  };
}