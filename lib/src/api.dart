import 'dart:convert';

import 'package:cyprus_mobdev_course/src/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getIOModule() async {
  return await SharedPreferences.getInstance();
}

bool isThereData(SharedPreferences ioModule) {
  final indexString = ioModule.getString("indexes");
  return !((indexString == null) || (indexString == ""));
}

List<int> loadTasksIndexes(SharedPreferences ioModule) {
  final indexString = ioModule.getString("indexes")!;
  List<int> indexes = [];
  for (String index in indexString.split(" ")) {
    if(index == ""){
      continue;
    }
    print(index);
    indexes.add(int.parse(index));
  }
  return indexes;
}

Task loadTask({required int id, required SharedPreferences ioModule}) {
  final jsonString = ioModule.getString('task$id')!;
  return Task.fromJson(jsonString);
}

saveTask({required Task task, required SharedPreferences ioModule}) async {
  var jsonString = json.encode(task.toJsonDict());
  ioModule.setString('task${task.id}', jsonString);
}

saveIndexes(
    {required List<int> indexes,
    required SharedPreferences ioModule}) {
  var result = "";
  for (int index in indexes){
    result += "$index ";
  }
  ioModule.setString("indexes", result);
}
