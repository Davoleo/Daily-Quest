import 'dart:convert';
import 'dart:io';

import 'package:daily_quest/model/Task.dart';
import 'package:daily_quest/utils/functions.dart';
import 'package:path_provider/path_provider.dart';

JsonEncoder encoder;

Directory dataDir;
File jsonFile;
bool isReady = false;

void initFileConnection(Function callback) {
  getApplicationDocumentsDirectory().then((Directory directory) {
    dataDir = directory;
    jsonFile = new File(dataDir.path + "/quests.json");
    if (!jsonFile.existsSync()) {
      jsonFile.writeAsStringSync("[]");
    }

    encoder = JsonEncoder.withIndent('  ');
    isReady = true;
    callback();
  });
}

void appendData(Map<String, dynamic> entry) {
  if (!isReady)
    return;

  isReady = false;
  jsonFile.writeAsString(jsonEncode(entry), mode: FileMode.append)
      .then((_) => isReady = true);
}

void saveOverwriteData(List<Map<String, dynamic>> entries) async {
  if (!isReady)
    return;

  String encoded = jsonEncode(entries);
  isReady = false;
  await jsonFile.writeAsString(encoded, mode: FileMode.write);
  isReady = true;
}

Future<List<Task>> loadData() async {

  if (!isReady) {
    print("Delaying data loading");
    return Future.delayed(new Duration(milliseconds: 100), loadData);
  }

  String jsonString = await jsonFile.readAsString();
  Iterable array = jsonDecode(jsonString);
  List<Task> tasks = UtilFunctions.getAllTasksFromMapList(array);
  return tasks;
}