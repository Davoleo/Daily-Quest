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
      //TODO TBC
      jsonFile.writeAsStringSync("{}");
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

void saveOverwriteData(List<Map<String, dynamic>> entries) {
  if (!isReady)
    return;

  isReady = false;
  entries.map((entry) => jsonEncode(entry)).forEach((string) {
    jsonFile.writeAsString(string, mode: FileMode.write)
        .then((_) => isReady = true);
  });
}

Future<List<Map<String, dynamic>>> loadData() async {
  if (!isReady)
    return null;
  return jsonDecode(await jsonFile.readAsString());
}