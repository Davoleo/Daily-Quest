import 'package:daily_quest/model/Task.dart';

TaskFrequency getFrequencyFromString(String freqString) {
  for (TaskFrequency freq in TaskFrequency.values) {
    if (freq.toString() == freqString) {
      return freq;
    }
  }

  return null;
}

List<Task> getAllTasksFromMapList(Iterable jsonTasks) {
  return jsonTasks.map((jTask) => Task.fromJsonMap(jTask)).toList();
}

List<Map<String, dynamic>> serializeAllTasks(List<Task> tasks) {
  return tasks.map((task) => task.toJson()).toList();
}

Future<void> waitUntilTrue(BoolWrapper value) async {
  if (!value.get()) {
    print("fjaklsljlksgjaklsjaklsjfaklsjaklsf");
    Future.delayed(new Duration(milliseconds: 200));
    waitUntilTrue(value);
    //wait
  }
  return;
}

class BoolWrapper {

  bool _value;

  BoolWrapper(this._value);

  bool get() => _value;
}