import 'package:daily_quest/model/Task.dart';

TaskFrequency getFrequencyFromString(String freqString) {
  for (TaskFrequency freq in TaskFrequency.values) {
    if (freq.toString() == freqString) {
      return freq;
    }
  }

  return null;
}

List<Task> getAllTasksFromMapList(List<Map<String, dynamic>> jsonTasks) {
  return jsonTasks.map((jTask) => Task.fromJsonMap(jTask)).toList();
}

List<Map<String, dynamic>> serializeAllTasks(List<Task> tasks) {
  return tasks.map((task) => task.toJson()).toList();
}