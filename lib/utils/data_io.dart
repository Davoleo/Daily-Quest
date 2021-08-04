import 'dart:convert';
import 'dart:io';

import 'package:daily_quest/model/Task.dart';
import 'package:daily_quest/utils/functions.dart';
import 'package:path_provider/path_provider.dart';

class IOManager {

  static const String filename = "quests.json";

  late final JsonEncoder encoder;
  late final Directory dataDir;
  late final File jsonFile;
  late final bool fileExists;

  bool ready = false;

  IOManager(Function callback) {
    getApplicationDocumentsDirectory().then((Directory directory) {
      dataDir = directory;
      jsonFile = new File(dataDir.path + "/" + filename);
      fileExists = jsonFile.existsSync();
      if (!fileExists) {
        jsonFile.createSync();
        jsonFile.writeAsString("[]");
      }

      encoder = JsonEncoder.withIndent('  ');
      ready = true;
      callback();
    });
  }

  void appendTask(Task task) async {
    if (!ready)
      return;

    print("Writing to file!");

    ready = false;
    String original = await jsonFile.readAsString();
    List<dynamic> originalMaps = json.decode(original);
    originalMaps.add(task.toJson());
    await jsonFile.writeAsString(json.encode(originalMaps), mode: FileMode.write);
    ready = true;
  }

  void removeTask(Task task) async {
    if (!ready)
      return;


    ready = false;
    String original = await jsonFile.readAsString();
    List<Task> tasks = UtilFunctions.getAllTasksFromMapList(json.decode(original));
    tasks.removeWhere((element) => element == task);
    String jsonTasks = json.encode(UtilFunctions.serializeAllTasks(tasks));
    await jsonFile.writeAsString(jsonTasks);
    ready = true;
  }

  replaceAllTasks(List<Task> newTasks) async {
    if (!ready)
      return;

    ready = false;
    String serializedTasks = json.encode(UtilFunctions.serializeAllTasks(newTasks));
    await jsonFile.writeAsString(serializedTasks);
    ready = true;
  }

  Future<List<Task>> loadData() async {
    if (!ready) {
      print("Delaying data loading");
      return Future.delayed(new Duration(milliseconds: 500), loadData);
    }

    String jsonString = await jsonFile.readAsString();
    Iterable array = jsonDecode(jsonString);
    List<Task> tasks = UtilFunctions.getAllTasksFromMapList(array);
    return tasks;
  }
}