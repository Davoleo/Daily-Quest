import 'package:daily_quest/model/Task.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Task> taskList = [
    Task(UniqueKey(), "djkasdjaskd"),
    Task(UniqueKey(), "djkasdjaskd"),
    Task(UniqueKey(), "djkasdjaskd"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        child: ListView.builder()
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}
