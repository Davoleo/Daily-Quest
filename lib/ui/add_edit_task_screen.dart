import 'package:daily_quest/model/Task.dart';
import 'package:daily_quest/ui/component/IconPicker.dart';
import 'package:daily_quest/utils/constants.dart';
import 'package:flutter/material.dart';

class AddEditTaskScreen extends StatefulWidget {

  final bool edit;
  final Task previousTask;

  TimeOfDay _timeOccurence;

  final List<DropdownMenuItem<TaskFrequency>> _categories = [];

  AddEditTaskScreen(this.edit, [this.previousTask])
      : _timeOccurence = TimeOfDay(hour: edit ? previousTask.dateTime.hour : 0, minute: edit ? previousTask.dateTime.minute : 0)
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

  TaskFrequency category;
  Icon currentIcon = Icon(Icons.emoji_emotions_outlined);

  @override
  Widget build(BuildContext context) {

    TextButton timeOccurranceButton = TextButton(
      onPressed: () => showTimePicker(context: context, initialTime: widget._timeOccurence).then((value) {
        if (value != null) {
          setState(() {
            widget._timeOccurence = value;
          });
        }
      }),
      style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
            side: BorderSide(width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ))
      ),
      child: Text(
        "Task Occurrence: " + widget._timeOccurence.format(context),
        style: TextStyle(
          color: Theme.of(context).primaryColorDark,
          fontSize: 18,
        ),
      ),
    );

    Widget frequencyConfig;

    switch(category) {
      case TaskFrequency.Daily:
        frequencyConfig = Container(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 50),
          child: timeOccurranceButton
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
              )
            ],
          ),
          frequencyConfig
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
              onPressed: () => {}
          ),
        ],
      ),
      body: content,
    );
  }
}
