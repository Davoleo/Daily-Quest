import 'package:daily_quest/model/Task.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeStampView extends StatelessWidget {

  final EdgeInsets _padding;
  final DateTime _dateTime;
  final TaskFrequency _taskType;

  DateTimeStampView(this._dateTime, this._taskType, [this._padding = EdgeInsets.zero]);

  @override
  Widget build(BuildContext context) {

    DateFormat formatter = Task.getFormatter(_taskType);
    String dateTimeString = formatter.format(_dateTime);

    return Container(
      padding: _padding,
      child: Text(
        dateTimeString,
        style: TextStyle(
          fontFamily: "JetbrainsMono",
          color: Colors.black54
        ),
      ),
    );
  }
}
