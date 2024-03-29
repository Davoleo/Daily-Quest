import 'package:daily_quest/model/Task.dart';
import 'package:daily_quest/ui/component/DateTimeStampView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskView extends StatefulWidget {
  final Task task;
  final Function deleteFunction;

  TaskView(this.task, this.deleteFunction);

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    Color darkPrimary = Theme.of(context).primaryColorDark;

    return Container(
      child: Dismissible(
        key: ValueKey(widget.task.title),
        onDismissed: (_) {
          widget.deleteFunction(widget.task.title);
        },
        direction: DismissDirection.endToStart,
        background: DecoratedBox(
          decoration: BoxDecoration(color: Colors.grey[700]),
          child: Align(
            alignment: AlignmentDirectional(0.8, 0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
        child: TextButton(
          onPressed: () => {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Icon(
                  widget.task.icon,
                  color: darkPrimary,
                ),
              ),
              Expanded(child:
                Column(
                  children: <Widget>[
                    DateTimeStampView(widget.task.nextDateTime(), widget.task.taskType),
                    Text(
                      widget.task.title,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: widget.task.complete ? Colors.black54 : Colors.black,
                        decoration: widget.task.complete ? TextDecoration.lineThrough : TextDecoration.none
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
                      if (isChecked != null)
                        widget.task.complete = isChecked;
                    });
                  },
                  activeColor: darkPrimary,
                  checkColor: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
