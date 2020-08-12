import 'package:daily_quest/model/Task.dart';
import 'package:flutter/material.dart';

class TaskView extends StatefulWidget {
  final Task task;

  TaskView(this.task);

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Dismissible(
          key: UniqueKey(),
          child: Text(widget.task.title)

      ),
    );
  }
}
