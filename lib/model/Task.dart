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
  String title;
  String notes = "";
  IconData icon = Icons.title;
  List<DateTime> occurrences;

  //Type of task
  TaskFrequency taskType;
  bool advanced = false;

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
      this.notes,
      this.icon,
    ]
  ) {
    DateTime current = DateTime.now();
    occurrences = [
      DateTime(current.year, current.month, current.day, timeOccurrence.hour, timeOccurrence.minute)
    ];
    this.taskType = TaskFrequency.Daily;
  }

  /// Constructs a weekly Task
  /// Given a [weekDay] and a [timeOccurrence]
  Task.weekly(
      this.title,
      TimeOfDay timeOccurrence,
      DayOfWeek weekDay,
      [
        this.notes,
        this.icon,
      ]
  ) {
    occurrences = [
      weekDay.thisWeekDateTime(timeOccurrence)
    ];
  }

  /// Constructs monthly Task
  /// Given a [dayOfMonth] and a [timeOccurrence]
  Task.monthly(
      this.title,
      TimeOfDay timeOccurrence,
      int dayOfMonth,
      [
        this.notes,
        this.icon,
        this.anticipateOccurrenceOnShorterMonths,
      ]
  ) {
    DateTime current = DateTime.now();
    int nextMonth = current.month == DateTime.december ? DateTime.january : current.month + 1;
    occurrences = [
      DateTime(current.year, nextMonth, dayOfMonth, timeOccurrence.hour, timeOccurrence.minute)
    ];
  }

  /// Constructs a yearly task
  /// Given a [date] (only month and day parameters are used) and a [timeOccurrence]
  Task.yearly(
      this.title,
      TimeOfDay timeOccurrence,
      DateTime date,
      [
        this.notes,
        this.icon,
      ]
  ) {
    DateTime current = DateTime.now();
    DateTime dateTime;
    if (current.isAfter(dateTime))
      dateTime = DateTime(current.year + 1, date.month, date.day, timeOccurrence.hour, timeOccurrence.minute);
    else
      dateTime = DateTime(current.year, date.month, date.day, timeOccurrence.hour, timeOccurrence.minute);
    occurrences = [dateTime];
  }

  /// Adds a list of occurrences to the same task
  void setAdvanced(List<DateTime> additional) {
    advanced = true;
    additional.forEach((element) {
      if (occurrences[0] != element)
        occurrences.add(element);
    });
  }

  DateTime nextDateTime() {
    DateTime next;
    occurrences.forEach((datetime) {
      if (datetime.isAfter(DateTime.now()))
        next = datetime;
    });

    if (next == null) {
      _updateAllTaskOccurrences();
      return nextDateTime();
    }
    else return next;
  }

  void _updateAllTaskOccurrences() {
    occurrences.forEach((datetime) {
      if (datetime.isBefore(DateTime.now())) {
        switch(taskType) {
          case TaskFrequency.Daily:
            datetime = datetime.add(Duration(days: 1));
            break;
          case TaskFrequency.Weekly:
            datetime = datetime.add(Duration(days: 7));
            break;
          case TaskFrequency.Monthly:
            int newMonth = datetime.month == DateTime.december ? DateTime.january : datetime.month + 1;
            int monthDays = getDayCountForMonthNumber(datetime.year, newMonth);
            int day = datetime.day;
            if (day > monthDays) {
              if (anticipateOccurrenceOnShorterMonths)
                day = monthDays;
              else
                newMonth++;
            }
            datetime = DateTime(datetime.year, newMonth, day, datetime.hour, datetime.minute);
            break;
          case TaskFrequency.Yearly:
            datetime = DateTime(datetime.year + 1, datetime.month, datetime.day, datetime.hour, datetime.minute);
            break;
        }
      }
    });
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
        taskType = UtilFunctions.getFrequencyFromString(json["frequency"]),
        occurrences = List.generate(json["occurrences"].length, (i) => DateTime.fromMillisecondsSinceEpoch(json["occurrences"][i])),
        advanced = json["occurrences"].length > 1
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
    'occurrences': List.generate(occurrences.length, (index) => occurrences[index].millisecondsSinceEpoch),
  };
}