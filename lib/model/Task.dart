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

  //Properties
  final String title;
  final String notes;
  final IconData icon;
  late DateTime occurrence;

  //Type of task
  late TaskFrequency taskType;

  //Extra
  bool anticipateOccurrenceOnShorterMonths = false;

  //State
  bool complete = false;

  /// Constructs a daily Task
  /// Given a timeOccurrence
  Task.daily(
    this.title,
    TimeOfDay timeOccurrence,
    [
      this.notes = "",
      this.icon = Icons.title,
    ]
  ) {
    DateTime current = DateTime.now();
    occurrence = DateTime(current.year, current.month, current.day, timeOccurrence.hour, timeOccurrence.minute);
    this.taskType = TaskFrequency.Daily;
  }

  /// Constructs a weekly Task
  /// Given a [weekDay] and a [timeOccurrence]
  Task.weekly(
      this.title,
      TimeOfDay timeOccurrence,
      DayOfWeek weekDay,
      [
        this.notes = "",
        this.icon = Icons.title,
      ]
  ) {
    this.taskType = TaskFrequency.Weekly;
    occurrence = weekDay.thisWeekDateTime(timeOccurrence);
  }

  /// Constructs monthly Task
  /// Given a [dayOfMonth] and a [timeOccurrence]
  Task.monthly(
      this.title,
      TimeOfDay timeOccurrence,
      int dayOfMonth,
      [
        this.notes = "",
        this.icon = Icons.title,
        this.anticipateOccurrenceOnShorterMonths = false,
      ]
  ) {
    taskType = TaskFrequency.Monthly;
    DateTime current = DateTime.now();
    int nextMonth = current.month == DateTime.december ? DateTime.january : current.month + 1;
    occurrence = DateTime(current.year, nextMonth, dayOfMonth, timeOccurrence.hour, timeOccurrence.minute);
  }

  /// Constructs a yearly task
  /// Given a [date] (only month and day parameters are used) and a [timeOccurrence]
  Task.yearly(
      this.title,
      TimeOfDay timeOccurrence,
      Month month,
      int day,
      [
        this.notes = "",
        this.icon = Icons.title,
      ]
  ) {
    taskType = TaskFrequency.Yearly;
    DateTime current = DateTime.now();
    DateTime dateTime = DateTime(current.year, month.ordinal, day, timeOccurrence.hour, timeOccurrence.minute);
    if (current.isAfter(dateTime))
      dateTime = DateTime(current.year + 1, month.ordinal, day, timeOccurrence.hour, timeOccurrence.minute);
    else
      dateTime = DateTime(current.year, month.ordinal, day, timeOccurrence.hour, timeOccurrence.minute);
    occurrence = dateTime;
  }

  DateTime nextDateTime() {
    DateTime? next;
    if (occurrence.isAfter(DateTime.now()))
      next = occurrence;

    if (next == null) {
      _updateTaskOccurrence();
      return nextDateTime();
    }
    else return next;
  }

  void _updateTaskOccurrence() {
    if (occurrence.isBefore(DateTime.now())) {
      switch(taskType) {
        case TaskFrequency.Daily:
          occurrence = occurrence.add(Duration(days: 1));
          break;
        case TaskFrequency.Weekly:
          occurrence = occurrence.add(Duration(days: 7));
          break;
        case TaskFrequency.Monthly:
          int newMonth = occurrence.month == DateTime.december ? DateTime.january : occurrence.month + 1;
          int monthDays = getDayCountForMonthNumber(occurrence.year, newMonth);
          int day = occurrence.day;
          if (day > monthDays) {
            if (anticipateOccurrenceOnShorterMonths)
              day = monthDays;
            else
              newMonth++;
          }
          occurrence = DateTime(occurrence.year, newMonth, day, occurrence.hour, occurrence.minute);
          break;
        case TaskFrequency.Yearly:
          occurrence = DateTime(occurrence.year + 1, occurrence.month, occurrence.day, occurrence.hour, occurrence.minute);
          break;
      }
    }
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

  ///JSON deserialization
  Task.fromJsonMap(Map<String, dynamic> json) :
        title = json["title"],
        notes = json["notes"],
        complete = json["complete"],
        icon = new IconData(json["icon"], fontFamily: "MaterialIcons"),
        taskType = UtilFunctions.getFrequencyFromString(json["frequency"])!,
        occurrence = DateTime.fromMillisecondsSinceEpoch(json["occurrence"])
  {
    if (taskType == TaskFrequency.Monthly)
      anticipateOccurrenceOnShorterMonths = json["monthly_anticipate"];
    else
      anticipateOccurrenceOnShorterMonths = false;
  }

  ///JSON Serialization
  Map<String, dynamic> toJson() => {
    'title': title,
    'notes': notes,
    'complete': complete,
    'icon': icon.codePoint,
    'frequency': taskType.toString(),
    'occurrence': occurrence.millisecondsSinceEpoch
  };

  @override
  int get hashCode {
    return hashValues(title, icon);
  }

  @override
  bool operator ==(Object other) {
    if (other is Task) {
      return this.title == other.title && this.icon == other.icon;
    }
    return false;
  }
}