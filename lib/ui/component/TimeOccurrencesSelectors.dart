import 'package:daily_quest/utils/constants.dart';
import 'package:flutter/material.dart';

class TimeOccurrenceButton extends StatefulWidget {

  final TimeOfDay prevTime;

  TimeOccurrenceButton(this.prevTime);

  @override
  _TimeOccurrenceButtonState createState() => _TimeOccurrenceButtonState();
}

class _TimeOccurrenceButtonState extends State<TimeOccurrenceButton> {

  TimeOfDay currentTime;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showTimePicker(context: context, initialTime: widget.prevTime).then((value) {
        if (value != null) {
          setState(() {
            print("Value is: " + value.toString());
            currentTime = value;
          });
        }
      }),
      style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            side: BorderSide(width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          )),
          overlayColor: MaterialStateProperty.all(Constants.primaryLight30)
      ),
      child: Text(
        "Task Occurrence: " + (currentTime == null ? widget.prevTime.format(context) : currentTime.format(context)),
        style: TextStyle(
          color: Theme.of(context).primaryColorDark,
          fontSize: 18,
        ),
      ),
    );
  }
}
