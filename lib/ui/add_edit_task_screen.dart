
import 'package:daily_quest/model/Task.dart';
import 'package:daily_quest/ui/component/IconPicker.dart';
import 'package:daily_quest/utils/constants.dart';
import 'package:flutter/material.dart';

class AddEditTaskScreen extends StatefulWidget {

  final bool edit;
  final Task previousTask;

  final List<DropdownMenuItem<TaskFrequency>> _categories = [];

  AddEditTaskScreen(this.edit, [this.previousTask]) {
    for (TaskFrequency freq in TaskFrequency.values) {
      String catName = freq.toString().split('.').last;
      _categories.add(new DropdownMenuItem(child: Text(catName)));
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

    Container content = Container(
      color: Constants.primaryLight30,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Wrap(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
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
                Text("Icon: "),
                IconButton(icon: currentIcon, onPressed: () async {
                  Icon choice = await widget._showIconPicker(context);
                  setState(() {
                    if (choice != null)
                      currentIcon = choice;
                  });
                }),
              ],
            ),
            DropdownButton<TaskFrequency>(
              underline: Divider(thickness: 2, color: Theme.of(context).primaryColor,),
              value: category,
              items: widget._categories,
              //Old Alternative
              // TaskFrequency.values
              //     .map<DropdownMenuItem<TaskFrequency>>(
              //         (TaskFrequency freq) => DropdownMenuItem(child: Text(freq.toString().split('.').last))
              onChanged: (value) {
                setState(() {
                  category = value;
                });
              },
            )
          ],
        ),
      ),
    );

    if (!widget.edit) {
      return Scaffold(
        appBar: AppBar(
          title: Text("New Task"),
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

    return Container();
  }
}
