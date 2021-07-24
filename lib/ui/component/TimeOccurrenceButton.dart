import 'package:daily_quest/utils/constants.dart';
import 'package:flutter/material.dart';

class TimeOccurrenceButton extends StatefulWidget {
  final _flatButtonStyle = ButtonStyle(
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        side: BorderSide(width: 1, style: BorderStyle.solid),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      )),
      overlayColor: MaterialStateProperty.all(Constants.primaryLight30)
  );

  _flatButtonTextStyle(context) => TextStyle(
    color: Theme.of(context).primaryColorDark,
    fontSize: 18,
  );

  final TimeOfDay? prevTaskTime;

  TimeOccurrenceButton([this.prevTaskTime]);

  @override
  _TimeOccurrenceButtonState createState() => _TimeOccurrenceButtonState();
}

class _TimeOccurrenceButtonState extends State<TimeOccurrenceButton> {

  late TimeOfDay currentTime;

  @override
  void initState() {
    super.initState();
    currentTime = widget.prevTaskTime ?? TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showTimePicker(context: context, initialTime: currentTime).then((value) {
        if (value != null) {
          setState(() {
            print("Value is: " + value.toString());
            currentTime = value;
          });
        }
      }),
      style: widget._flatButtonStyle,
      child: Text(
        "Task Occurrence: " + (currentTime.format(context)),
        style: widget._flatButtonTextStyle(context),
      ),
    );
  }
}

