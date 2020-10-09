import 'package:daily_quest/model/Task.dart';
import 'package:daily_quest/utils/constants.dart';
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
    Color darkPrimary = Theme.of(context).primaryColorDark;

    return Container(
      child: Dismissible(
          key: widget.task.id,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  widget.task.icon,
                  color: darkPrimary,
                ),
                Text(widget.task.title),
                Checkbox(
                  value: widget.task.complete,
                  onChanged: (isChecked) {
                    setState(() {
                      widget.task.complete = isChecked;
                    });
                  },
                  activeColor: darkPrimary,
                  checkColor: Theme.of(context).primaryColorLight,
                ),
              ],
            ),
          ),
      ),
    );
  }
}
