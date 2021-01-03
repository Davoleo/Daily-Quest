import 'dart:convert';
import 'dart:io';

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

Future<List<Map<String, dynamic>>> loadData() async {
  //FIX THIS (returns as a List<dynamic> instead of a list of maps)
  if (!isReady)
    return null;
  String jsonString = await jsonFile.readAsString();
  return jsonDecode(jsonString);
}