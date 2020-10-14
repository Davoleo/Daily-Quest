import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeStampView extends StatelessWidget {

  EdgeInsets _padding;
  final DateTime _dateTime;

  DateTimeStampView(this._dateTime, [this._padding = EdgeInsets.zero]);

  @override
  Widget build(BuildContext context) {

    DateFormat formatter = DateFormat('dd/MM/yy - HH:mm');
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
