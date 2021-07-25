import 'package:daily_quest/model/Task.dart';
import 'package:daily_quest/ui/component/IconPicker.dart';
import 'package:daily_quest/ui/component/SmartCheckbox.dart';
import 'package:daily_quest/ui/component/TimeOccurrenceButton.dart';
import 'package:daily_quest/utils/constants.dart';
import 'package:daily_quest/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddEditTaskScreen extends StatefulWidget {
  final bool edit;
  final Task? previousTask;

  final List<DropdownMenuItem<TaskFrequency>> _categories = [];

  final SizedBox _separatorBox20 = SizedBox(
    height: 20,
  );
  final TextStyle _taskConfigurationTitleStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

  AddEditTaskScreen(this.edit, [this.previousTask]) {
    for (TaskFrequency freq in TaskFrequency.values) {
      String catName = freq.toString().split('.').last;
      _categories.add(new DropdownMenuItem(
        child: Text(catName),
        value: freq,
      ));
    }
  }

  Future<Icon?> _showIconPicker(context) async {
    Icon? choice = await showDialog<Icon>(
        context: context,
        builder: (BuildContext context) {
          return IconPicker(
            title: const Text(
              "Select an Icon",
              style: TextStyle(fontSize: 24),
            ),
            icons: Constants.supportedTaskIcons,
          );
        });

    return choice;
  }

  @override
  _AddEditTaskScreenState createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  Icon currentIcon = Icon(Icons.title);
  TaskFrequency category = TaskFrequency.Daily;

  TimeOfDay occurrenceTime = TimeOfDay.now();

  //Weekly configuration
  List<bool> weekChoices = new List.filled(DateTime.daysPerWeek, false);

  //Month Configuration (use dayOfMonth over the controller [already parsed and validated])
  int dayOfMonth = 1;
  TextEditingController dayController = TextEditingController(text: "1");

  //Yearly Configuration
  List<bool> monthChoices = new List.filled(DateTime.monthsPerYear, false);

  @override
  void initState() {
    super.initState();
    dayController.addListener(() {
      if (dayController.text.isEmpty)
        return;
      int parsed = int.parse(dayController.text);
      if (parsed > 0 && parsed <= 31)
        dayOfMonth = parsed;
      else {
        setState(() {
          dayController.text = dayOfMonth.toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //TimeOccurrenceSelectors timeOccButtons = new TimeOccurrenceSelectors(advanced ? maxOccurrences : 1, _occList);

    final List<SCheckbox> weekCheckboxes = List.generate(
        DateTime.daysPerWeek,
        (index) => SCheckbox(
              label: Constants.weekDays[index].name,
              value: weekChoices[index],
              padding: const EdgeInsets.symmetric(horizontal: 8),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    weekChoices[index] = value;
                  });
                }
              },
            ));

    final List<SCheckbox> monthCheckboxes = List.generate(
        DateTime.monthsPerYear,
        (index) => SCheckbox(
              label: Constants.months[index].name,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              value: monthChoices[index],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    monthChoices[index] = value;
                  });
                }
              },
            ));

    Widget frequencyConfig;
    TimeOfDay? prevTaskTime = widget.previousTask != null
        ? UtilFunctions.timeOfDate(widget.previousTask!.occurrence)
        : null;

    switch (category) {
      case TaskFrequency.Daily:
        frequencyConfig = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Daily Task Configuration",
              style: widget._taskConfigurationTitleStyle,
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 50),
                child: TimeOccurrenceButton(prevTaskTime: prevTaskTime, onTimeChanged: (val) => occurrenceTime = val,))
          ],
        );
        break;

      case TaskFrequency.Weekly:
        frequencyConfig = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Weekly Task Configuration",
              style: widget._taskConfigurationTitleStyle,
            ),
            widget._separatorBox20,
            TimeOccurrenceButton(prevTaskTime: prevTaskTime, onTimeChanged: (val) => occurrenceTime = val,),
            widget._separatorBox20,
            Wrap(
              direction: Axis.horizontal,
              children: weekCheckboxes,
            )
          ],
        );
        break;

      case TaskFrequency.Monthly:
        frequencyConfig = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Monthly Task Configuration",
              style: widget._taskConfigurationTitleStyle,
            ),
            widget._separatorBox20,
            TimeOccurrenceButton(prevTaskTime: prevTaskTime, onTimeChanged: (val) => occurrenceTime = val,),
            widget._separatorBox20,
            TextField(
              controller: dayController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
            )
          ],
        );
        break;

      case TaskFrequency.Yearly:
        frequencyConfig = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Yearly Task Configuration",
              style: widget._taskConfigurationTitleStyle,
            ),
            widget._separatorBox20,
            TimeOccurrenceButton(prevTaskTime: prevTaskTime, onTimeChanged: (val) => occurrenceTime = val,),
            widget._separatorBox20,
            Wrap(
              direction: Axis.horizontal,
              children: monthCheckboxes,
            ),
            widget._separatorBox20,
            TextField(
              controller: dayController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
            )
          ],
        );
        break;
      case TaskFrequency.Yearly:

      default:
        frequencyConfig = Container();
    }

    Container content = Container(
      color: Constants.primaryLight30,
      child: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 20,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: Constants.fieldOutline,
                  labelText: "Title",
                ),
              ),
              TextField(
                controller: descController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 3,
                decoration: InputDecoration(
                  border: Constants.fieldOutline,
                  labelText: "Notes",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Icon: ",
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                      icon: currentIcon,
                      onPressed: () async {
                        Icon? choice = await widget._showIconPicker(context);
                        if (choice != null) {
                          setState(() {
                            currentIcon = choice;
                            //Clear focus from the text field so that it doesn't go back to it
                            FocusScope.of(context).requestFocus(FocusNode());
                          });
                        }
                      }),
                ],
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 150),
                //padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: DropdownButtonFormField<TaskFrequency>(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, style: BorderStyle.solid)),
                      labelText: "Task Type"),
                  value: category,
                  items: widget._categories,
                  onChanged: (value) {
                    setState(() {
                      //Clear focus from the text field so that it doesn't go back to it
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (value != null) category = value;
                    });
                  },
                ),
              ),
            ],
          ),
          AnimatedSize(
            duration: Duration(milliseconds: 750),
            vsync: this,
            child: Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColorDark),
                  borderRadius: BorderRadius.circular(8)),
              child: frequencyConfig,
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.edit ? "Edit Task" : "New Task"),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              Task newTask;
              switch(category) {
                case TaskFrequency.Daily:
                  newTask = Task.daily(titleController.text, occurrenceTime,
                      descController.text, currentIcon.icon!);
                  break;
                case TaskFrequency.Weekly:
                  newTask = Task.weekly(titleController.text, occurrenceTime,
                      Constants.weekDays[weekChoices.indexOf(true)], descController.text, currentIcon.icon!);
                  break;
                case TaskFrequency.Monthly:
                  newTask = Task.monthly(titleController.text, occurrenceTime,
                      dayOfMonth, descController.text, currentIcon.icon!);
                  break;
                case TaskFrequency.Yearly:
                  newTask = Task.yearly(titleController.text, occurrenceTime,
                      Constants.months[monthChoices.indexOf(true)], dayOfMonth,
                      descController.text, currentIcon.icon!);
                  break;
              }

              Navigator.pop(context, newTask);
            },
          ),
        ],
      ),
      body: content,
    );
  }
}
