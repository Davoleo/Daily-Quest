import 'package:daily_quest/model/Task.dart';
import 'package:daily_quest/ui/component/IconPicker.dart';
import 'package:daily_quest/ui/component/TimeOccurrencesSelectors.dart';
import 'package:daily_quest/utils/constants.dart';
import 'package:flutter/material.dart';

class AddEditTaskScreen extends StatefulWidget {

  final bool edit;
  final Task previousTask;

  final List<DropdownMenuItem<TaskFrequency>> _categories = [];

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

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {

  String title = "";
  String notes = "";
  Icon currentIcon = Icon(Icons.emoji_emotions_outlined);
  TaskFrequency category = TaskFrequency.Daily;

  @override
  Widget build(BuildContext context) {

    List<TimeOccurrenceButton> timeOccButtons;
    //TODO Implement this list


    List<bool> weekChoices = new List.filled(7, false);
    final List<FittedBox> weekCheckboxes = List.generate(7, (index) => FittedBox(
      child: Row(
        children: [
          Text(Constants.weekDays[index].name),
          //TODO Fix checkbox state changes
          Checkbox(value: weekChoices[index], onChanged: (value) {
            setState(() {
              weekChoices[index] = value;
            }
            );})
        ],
      ),
    ));


    Widget frequencyConfig;

    switch(category) {
      case TaskFrequency.Daily:
        frequencyConfig = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Daily Task Configuration", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
            Container(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 50),
              child: TextButton(onPressed: null, child: Text("temp"))
            )
          ],
        );
        break;
      case TaskFrequency.Weekly:
        frequencyConfig = Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            children: [
              TextButton(onPressed: null, child: Text("temp")),
              Wrap(
                direction: Axis.horizontal,
                children: weekCheckboxes,
              )
            ],
          ),
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
                      category = value;
                    });
                  },
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColorDark),
              borderRadius: BorderRadius.circular(8),
            ),
            child: frequencyConfig,
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
