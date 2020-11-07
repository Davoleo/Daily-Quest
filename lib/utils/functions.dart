import 'package:daily_quest/model/Task.dart';

TaskFrequency getFrequencyFromString(String freqString) {
  for (TaskFrequency freq in TaskFrequency.values) {
    if (freq.toString() == freqString) {
      return freq;
    }
  }

  return null;
}