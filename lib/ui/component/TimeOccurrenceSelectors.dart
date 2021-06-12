import 'package:daily_quest/utils/constants.dart';
import 'package:flutter/material.dart';

class TimeOccurrenceSelectors extends StatefulWidget {

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

  final List<TimeOfDay> prevTimeList;
  final int maxOccurrences;

  TimeOccurrenceSelectors(this.maxOccurrences, [this.prevTimeList]);

  @override
  _TimeOccurrenceSelectorsState createState() => _TimeOccurrenceSelectorsState();
}

class _TimeOccurrenceSelectorsState extends State<TimeOccurrenceSelectors> {

  List<TimeOfDay> currentTimeList;

  @override
  void initState() {
    super.initState();
    currentTimeList = widget.prevTimeList == null ? [] : List.of(widget.prevTimeList);
  }

  @override
  Widget build(BuildContext context) {

    TextButton addButton = TextButton(
      onPressed: currentTimeList.length == widget.maxOccurrences ? null : () {
        setState(() {
          currentTimeList.add(TimeOfDay(hour: 0, minute: 0));
        });
      },
      child: Text("Add", style: widget._flatButtonTextStyle(context),),
      style: widget._flatButtonStyle,
    );

    if (currentTimeList != null) {
      return Column(
        children: [
          Wrap(
            children: List.generate(currentTimeList.length, (index) {
              return Row(
                children: [
                  TextButton(
                    onPressed: () => showTimePicker(context: context, initialTime: currentTimeList[index]).then((value) {
                      if (value != null) {
                        setState(() {
                          print("Value is: " + value.toString());
                          currentTimeList[index] = value;
                        });
                      }
                    }),
                    style: widget._flatButtonStyle,
                    child: Text(
                      "Task Occurrence: " + (currentTimeList[index].format(context)),
                      style: widget._flatButtonTextStyle(context),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 36,
                    height: 36,
                    child: DecoratedBox(
                      child: IconButton(
                        icon: Icon(Icons.delete_outline),
                        onPressed: () {
                          setState(() {
                            currentTimeList.removeAt(index);
                          });
                        },
                        iconSize: 20,
                      ),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
          ),
          addButton
        ],
      );
    }
    else {
      return addButton;
    }
  }
}
