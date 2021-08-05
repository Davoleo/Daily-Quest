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

abstract class Task {

  final Key key;

  //Properties
  final String title;
  final String notes;
  final IconData icon;
  final TimeOfDay timeOccurrence;

  Task(this.key, this.title, this.notes, this.icon, this.timeOccurrence);

  //TODO MOVE TO TaskManager class
  //State
  @deprecated
  late DateTime occurrence;
  @deprecated
  bool complete = false;

  TaskFrequency getType();

  ///TODO Move to TaskManager class
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

  ///TODO Move to TaskManager Class
  void _updateTaskOccurrence() {
    if (occurrence.isBefore(DateTime.now())) {
      switch(getType()) {
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
            if ((this as TaskMonthly).anticipate)
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

  ///TODO Rework this
  ///JSON deserialization
  static Task fromJsonMap(Map<String, dynamic> json)
  {
    TaskFrequency type = UtilFunctions.getFrequencyFromString(json['frequency'])!;

    String title = json["title"];
    String notes = json["notes"];
    bool complete = json["complete"];
    IconData icon = new IconData(json["icon"], fontFamily: "MaterialIcons");

    Task task;
    switch(type) {
      case TaskFrequency.Daily:
        task = new TaskDaily(title: title, notes: notes, icon: icon, timeOccurrence: TimeOfDay.now());
        break;
      case TaskFrequency.Weekly:
        // TODO: Handle this case.
        break;
      case TaskFrequency.Monthly:
        //anticipateOccurrenceOnShorterMonths = json["monthly_anticipate"];
        break;
      case TaskFrequency.Yearly:
        // TODO: Handle this case.
        break;
    }

    return task;
  }

  ///JSON Serialization
  @mustCallSuper
  Map<String, dynamic> toJson() {
    final jsonMap = {
      'title': title,
      'notes': notes,
      'complete': complete,
      'icon': icon.codePoint,
      'frequency': this.getType(),
      'occurrence': occurrence.millisecondsSinceEpoch,
    };
    if (this.getType() == TaskFrequency.Monthly) {
      jsonMap['monthly_anticipate'] = (this as TaskMonthly).anticipate;
    }

    return jsonMap;
  }
}


class TaskDaily extends Task {

  static const Duration MAX = Duration(hours: 23);

  final bool periodic;
  final Duration interval;

  /// Constructs a daily Task
  /// Given a timeOccurrence
  TaskDaily({
    required String title,
    String notes = "",
    IconData icon = Icons.title,
    required TimeOfDay timeOccurrence,
    this.periodic = false,
    this.interval = Duration.zero
  }) : super(UniqueKey(), title, notes, icon, timeOccurrence) {
    if (periodic && (interval == Duration.zero || interval > MAX))
      throw ArgumentError("interval of a periodic task can't be zero!");
  }

  @override
  TaskFrequency getType() {
    return TaskFrequency.Daily;
  }
}

class TaskWeekly extends Task {

  final List<DayOfWeek> days;

  /// Constructs a weekly Task
  /// Given a [weekDay] and a [timeOccurrence]
  TaskWeekly({
    required String title,
    String notes = "",
    IconData icon = Icons.title,
    required TimeOfDay timeOccurrence,
    required this.days,
  }) : super(UniqueKey(), title, notes, icon, timeOccurrence);

  @override
  TaskFrequency getType() {
    return TaskFrequency.Weekly;
  }
}

class TaskMonthly extends Task {

  ///Anticipate Task Occurrence on shorter months
  bool anticipate = false;

  /// Constructs monthly Task
  /// Given a [dayOfMonth] and a [timeOccurrence]
  TaskMonthly({
    required String title,
    String notes = "",
    IconData icon = Icons.title,
    required TimeOfDay timeOccurrence,
    required this.anticipate
  }) : super(UniqueKey(), title, notes, icon, timeOccurrence);

  @override
  TaskFrequency getType() {
    return TaskFrequency.Monthly;
  }

// taskType = TaskFrequency.Monthly;
// DateTime current = DateTime.now();
// int nextMonth = current.month == DateTime.december ? DateTime.january : current.month + 1;
// occurrence = DateTime(current.year, nextMonth, dayOfMonth, timeOccurrence.hour, timeOccurrence.minute);
}

class TaskYearly extends Task {

  final List<Month> months;

  /// Constructs a yearly task
  /// Given a [date] (only month and day parameters are used) and a [timeOccurrence]
  TaskYearly({
    required String title,
    String notes = "",
    IconData icon = Icons.title,
    required TimeOfDay timeOccurrence,
    required this.months,
  }) : super(UniqueKey(), title, notes, icon, timeOccurrence);

  //Old Task MAnaging
// DateTime current = DateTime.now();
// DateTime dateTime = DateTime(current.year, month.ordinal, day, timeOccurrence.hour, timeOccurrence.minute);
// if (current.isAfter(dateTime))
// dateTime = DateTime(current.year + 1, month.ordinal, day, timeOccurrence.hour, timeOccurrence.minute);
// else
// dateTime = DateTime(current.year, month.ordinal, day, timeOccurrence.hour, timeOccurrence.minute);
// occurrence = dateTime;

  @override
  TaskFrequency getType() {
    return TaskFrequency.Yearly;
  }
}