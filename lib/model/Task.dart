import 'package:daily_quest/utils/constants.dart';
import 'package:daily_quest/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum TaskFrequency {
  Daily,
  Weekly,
  Monthly,
  Annual,
}

class Task {

  final String title;
  final String notes;
  bool complete = false;
  bool delayed = false;
  IconData icon;
  TaskFrequency taskType;
  Duration delay;
  DateTime dateTime;

  Task({
    @required this.title,
    this.notes = "",
    this.icon = Icons.title,
    @required this.taskType,
    @required this.delay,
    this.dateTime
  });

  DateTime nextDateTime() {
    //initialize the date if it's null
    dateTime = dateTime == null ? DateTime.now() : dateTime;

    //Check whether the set DateTime has already passed or not,
    //if it has update the DateTime to the next occurrence, return it and replace the old one
    if (dateTime.isAfter(DateTime.now()))
      return dateTime;
    else {
      DateTime next = dateTime.add(delay);
      dateTime = next;
      return next;
    }
  }

  static DateFormat getFormatter(TaskFrequency frequency) {
    switch(frequency) {
      case TaskFrequency.Daily:
        return Constants.dailyFormat;

      case TaskFrequency.Weekly:
        return Constants.weeklyFormat;

      case TaskFrequency.Monthly:
      case TaskFrequency.Annual:
      default:
        return Constants.monthlyFormat;
    }
  }

  ///JSON serialization
  Task.fromJsonMap(Map<String, dynamic> json) :
        title = json["title"],
        notes = json["notes"],
        complete = json["complete"],
        icon = new IconData(json["icon"], fontFamily: "MaterialIcons"),
        taskType = UtilFunctions.getFrequencyFromString(json["frequency"]),
        delay = Duration(seconds: json["delay"]);

  Map<String, dynamic> toJson() => {
    'title': title,
    'notes': notes,
    'complete': complete,
    'icon': icon.codePoint,
    'frequency': taskType.toString(),
    'delay': delay.inSeconds
  };
}