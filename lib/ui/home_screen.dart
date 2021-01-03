import 'package:daily_quest/model/Task.dart';
import 'package:daily_quest/ui/component/TaskView.dart';
import 'package:daily_quest/utils/constants.dart';
import 'package:daily_quest/utils/data_io.dart';
import 'package:daily_quest/utils/functions.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> taskList = [];

  @override
  void initState() {
    super.initState();
    initFileConnection(() {
      loadData().then((list) => taskList = getAllTasksFromMapList(list));
    });
  }

  removeTask(UniqueKey key) {
    setState(() {
      taskList.removeWhere((task) => task.id == key);
      var jsonList = taskList.map((task) => task.toJson()).toList();
      saveOverwriteData(jsonList);
      print("Length: ${taskList.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    Constants.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.notifications), onPressed: () => {}),
          IconButton(icon: Icon(Icons.search), onPressed: () => {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () => {}),
        ],
      ),
      body: Container(
        color: Constants.primaryLight30,
        child: ListView.separated(
          itemCount: taskList.length,
          separatorBuilder: (_, index) => Divider(
            color: Theme.of(context).primaryColorDark,
            height: 1,
            indent: Constants.dividerHPadding,
            endIndent: Constants.dividerHPadding,
          ),
          itemBuilder: (_, index) {
            if (index < taskList.length)
              return TaskView(taskList[index], removeTask);
            else
              return null;
          }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}
