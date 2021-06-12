import 'package:daily_quest/model/Task.dart';
import 'package:daily_quest/ui/component/IconPicker.dart';
import 'package:daily_quest/ui/component/SmartCheckbox.dart';
import 'package:daily_quest/ui/component/TimeOccurrenceSelectors.dart';
import 'package:daily_quest/utils/constants.dart';
import 'package:daily_quest/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddEditTaskScreen extends StatefulWidget {

  final bool edit;
  final Task previousTask;

  final List<DropdownMenuItem<TaskFrequency>> _categories = [];

  final SizedBox _separatorBox20 = SizedBox(height: 20,);

  AddEditTaskScreen(this.edit, [this.previousTask])
  {
    for (TaskFrequency freq in TaskFrequency.values) {
      String catName = freq.toString().split('.').last;
      _categories.add(new DropdownMenuItem(child: Text(catName), value: freq,));
    }
  }

  Future<Icon> _showIconPicker(context) async {
    Icon choice = await showDialog<Icon>(context: context, builder: (BuildContext context) {
      return IconPicker(
        title: const Text("Select an Icon", style: TextStyle(fontSize: 24),),
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

  String title = "";
  String notes = "";
  Icon currentIcon = Icon(Icons.emoji_emotions_outlined);
  TaskFrequency category = TaskFrequency.Daily;
  int maxOccurrences;

  List<bool> weekChoices = new List.filled(7, false);

  @override
  Widget build(BuildContext context) {
    switch(category) {
      case TaskFrequency.Daily:
        maxOccurrences = 12;
        break;
      case TaskFrequency.Weekly:
        maxOccurrences = 7;
        break;
      case TaskFrequency.Monthly:
        maxOccurrences = 1;
        break;
      case TaskFrequency.Yearly:
        maxOccurrences = 10;
        break;
    }

    List<TimeOfDay> _occList = widget.previousTask == null ? null : widget.previousTask.occurrences.map(UtilFunctions.timeOfDate);
    TimeOccurrenceSelectors timeOccButtons = new TimeOccurrenceSelectors(maxOccurrences, _occList);

    final List<SCheckbox> weekCheckboxes = List.generate(
        7, (index) =>
        SCheckbox(
          label: Constants.weekDays[index].name,
          value: weekChoices[index],
          padding: const EdgeInsets.symmetric(horizontal: 8),
          onChanged: (value) {
            setState(() {
              weekChoices[index] = value;
            });
          },
        )
    );


    Widget frequencyConfig;

    switch(category) {
      case TaskFrequency.Daily:
        frequencyConfig = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Daily Task Configuration", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
            Container(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 50),
              child: timeOccButtons
            )
          ],
        );
        break;
      case TaskFrequency.Weekly:
        frequencyConfig = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Weekly Task Configuration", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
            widget._separatorBox20,
            timeOccButtons,
            widget._separatorBox20,
            Wrap(
              direction: Axis.horizontal,
              children: weekCheckboxes,
            )
          ],
        );
        break;
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
                decoration: InputDecoration(
                  border: Constants.fieldOutline,
                  labelText: "Title",
                ),
              ),
              TextField(
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
                  Text("Icon: ", style: TextStyle(fontSize: 18),),
                  IconButton(icon: currentIcon, onPressed: () async {
                    Icon choice = await widget._showIconPicker(context);
                    setState(() {
                      if (choice != null)
                        currentIcon = choice;
                      //Clear focus from the text field so that it doesn't go back to it
                      FocusScope.of(context).requestFocus(FocusNode());
                    });
                  }),
                ],
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 150),
                //padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: DropdownButtonFormField<TaskFrequency>(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, style: BorderStyle.solid)
                      ),
                      labelText: "Task Type"
                  ),
                  value: category,
                  items: widget._categories,
                  onChanged: (value) {
                    setState(() {
                      //Clear focus from the text field so that it doesn't go back to it
                      FocusScope.of(context).requestFocus(FocusNode());
                      category = value;
                    });
                  },
                ),
              ),
            ],
          ),
          AnimatedSize(
            duration: Duration(milliseconds: 500),
            clipBehavior: Clip.hardEdge,
            vsync: this,
            child: Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColorDark),
                borderRadius: BorderRadius.circular(8)
              ),
              child: frequencyConfig,
            ),
          )
        ],
      ),
    );


    if (!widget.edit) {

    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.edit ? "Edit Task" : "New Task"),
        actions: [
          IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                //TODO Build new task
                Task newTask;
              }
          ),
        ],
      ),
      body: content,
    );
  }
}
