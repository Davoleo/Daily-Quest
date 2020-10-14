import 'package:daily_quest/model/Task.dart';
import 'package:daily_quest/ui/component/DateTimeStampView.dart';
import 'package:flutter/cupertino.dart';
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
          child: FlatButton(
            onPressed: () => {},
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Icon(
                    widget.task.icon,
                    color: darkPrimary,
                  ),
                ),
                Expanded(child:
                  Column(
                    children: <Widget>[
                      DateTimeStampView(DateTime.now()),
                      Text(
                        widget.task.title,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Checkbox(
                    value: widget.task.complete,
                    onChanged: (isChecked) {
                      setState(() {
                        widget.task.complete = isChecked;
                      });
                    },
                    activeColor: darkPrimary,
                    checkColor: Theme.of(context).primaryColorLight,
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
