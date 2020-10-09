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
    Task(UniqueKey(), "Set the right temperature settings for the season", Icons.ac_unit),
    Task(UniqueKey(), "Wake up after resting in the afternoon", Icons.access_alarm),
    Task(UniqueKey(), "Take my grandma to the weekly doctor visit", Icons.accessible),
  ];

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
        child: ListView.builder(
          itemBuilder: (_, index) {
            if (index < taskList.length)
              return TaskView(taskList[index]);
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
