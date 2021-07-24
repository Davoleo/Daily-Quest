import 'package:daily_quest/model/Task.dart';
import 'package:flutter/material.dart';

abstract class UtilFunctions {
  static TaskFrequency? getFrequencyFromString(String freqString) {
    for (TaskFrequency freq in TaskFrequency.values) {
      if (freq.toString() == freqString) {
        return freq;
      }
    }

    return null;
  }

  static List<Task> getAllTasksFromMapList(Iterable jsonTasks) {
    return jsonTasks.map((jTask) => Task.fromJsonMap(jTask)).toList();
  }

  static List<Map<String, dynamic>> serializeAllTasks(List<Task> tasks) {
    return tasks.map((task) => task.toJson()).toList();
  }

  static TimeOfDay timeOfDate(DateTime datetime) {
    return TimeOfDay(hour: datetime.hour, minute: datetime.minute);
  }
}