import 'package:daily_quest/model/Task.dart';
import 'package:daily_quest/ui/component/TaskView.dart';
import 'package:daily_quest/utils/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> taskList = [
    Task(id: UniqueKey(), title: "Set the right temperature settings for the season", icon: Icons.ac_unit, taskType: TaskFrequency.annual, delay: Duration(days: 365)),
    Task(id: UniqueKey(), title: "Wake up after resting in the afternoon", icon: Icons.access_alarm, taskType: TaskFrequency.daily, delay: Duration(days: 1)),
    Task(id: UniqueKey(), title: "Take my grandma to the weekly doctor visit", icon: Icons.accessible, taskType: TaskFrequency.weekly, delay: Duration(days: 7)),
  ];

  removeTask(UniqueKey key) {
    setState(() {
      taskList.removeWhere((task) => task.id == key);
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
