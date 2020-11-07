import 'dart:convert';

import 'package:daily_quest/utils/constants.dart';
import 'package:daily_quest/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum TaskFrequency {
  daily,
  weekly,
  monthly,
  annual,
}

class Task {

  final UniqueKey id;
  String title;
  bool complete = false;
  bool delayed = false;
  IconData icon;
  TaskFrequency taskType;
  Duration delay;
  DateTime dateTime;

  Task({
    @required this.id,
    @required this.title,
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
      case TaskFrequency.daily:
        return Constants.dailyFormat;

      case TaskFrequency.weekly:
        return Constants.weeklyFormat;

      case TaskFrequency.monthly:
      case TaskFrequency.annual:
      default:
        return Constants.monthlyFormat;
    }
  }

  ///JSON serialization
  Task.fromJsonMap(Map<String, dynamic> json) :
        id = json["id"],
        title = json["title"],
        complete = json["complete"],
        icon = new IconData(json["icon"]),
        taskType = getFrequencyFromString(json["frequency"]),
        delay = Duration(seconds: json["delay"]);

  Map<String, dynamic> mapJsonString(String json) {
    jsonDecode(json);
  }

  Map<String, dynamic> toJsonMap() => {
    'id': id.toString(),
    'title': title,
    'icon': icon.codePoint,
    'frequency': taskType.toString(),
    'delay': delay.inSeconds
  };

  String toJsonString(Map<String, dynamic> jsonMap) {
    return jsonEncode(toJsonMap());
  }
}