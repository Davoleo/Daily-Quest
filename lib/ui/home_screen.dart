import 'package:daily_quest/model/Task.dart';
import 'package:daily_quest/ui/add_edit_task_screen.dart';
import 'package:daily_quest/ui/component/TaskView.dart';
import 'package:daily_quest/utils/constants.dart';
import 'package:daily_quest/utils/data_io.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> taskList = [];

  @override
  void initState() {
    super.initState();
    initFileConnection(() {
      // taskList.add(Task(title: "Set the right temperature settings for the season", icon: Icons.ac_unit, taskType: TaskFrequency.annual, delay: Duration(days: 365)));
      // taskList.add(Task(title: "Wake up after resting in the afternoon", icon: Icons.access_alarm, taskType: TaskFrequency.daily, delay: Duration(days: 1)));
      // taskList.add(Task(title: "Take my grandma to the weekly doctor visit", icon: Icons.accessible, taskType: TaskFrequency.weekly, delay: Duration(days: 7)));
      // saveOverwriteData(serializeAllTasks(taskList));
    });
  }

  removeTask(String title) {
    setState(() {
      taskList.removeWhere((task) => task.title == title);
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
        child: FutureBuilder(
          future: loadData(),
          builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
            if (snapshot.hasError)
              return Center(child: Text("An error occurred while loading data\nError: " + snapshot.error.toString()));
            if (!snapshot.hasData)
              return Center(child: Text("No data to load!"));
            if (snapshot.connectionState == ConnectionState.done) {
              this.taskList = snapshot.data!;
              return ListView.separated(
                itemCount: snapshot.data!.length,
                separatorBuilder: (_, index) => Divider(
                  color: Theme.of(context).primaryColorDark,
                  height: 1,
                  indent: Constants.dividerHPadding,
                  endIndent: Constants.dividerHPadding,
                ),
                itemBuilder: (_, index) {
                  if (index < snapshot.data!.length)
                    return TaskView(snapshot.data![index], removeTask);
                  else
                    return Center(child: Text("No data to load!"));
                },
              );
            }
            else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditTaskScreen(false)));
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}
