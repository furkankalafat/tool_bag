import 'package:flutter/material.dart';
import 'package:my_tool_bag/Models/Task.dart';
import 'package:my_tool_bag/Services/DbServicesTask.dart';

class AddTODO extends StatefulWidget {
  final Function refreshTaskList;
  final Task task;

  AddTODO({
    this.refreshTaskList,
    this.task,
  });

  @override
  _AddTODOState createState() => _AddTODOState();
}

class _AddTODOState extends State<AddTODO> {
  final _formKey = GlobalKey<FormState>();
  String _title;
  String _priority;
  final List<String> _priorities = ["!", "!!", "!!!"];

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _title = widget.task.title;
      _priority = widget.task.priority;
    }
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print("$_title, $_priority");

      Task task = Task(title: _title, priority: _priority);
      if (widget.task == null) {
        task.status = 0;
        DbServicesTask.instance.insertTask(task);
      } else {
        task.id = widget.task.id;
        task.status = widget.task.status;
        DbServicesTask.instance.updateTask(task);
      }
      widget.refreshTaskList();
      Navigator.pop(context);
    }
  }

  _delete() {
    DbServicesTask.instance.deleteTask(widget.task.id);
    widget.refreshTaskList();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.green[800],
        title: Text(
          widget.task == null ? 'ADD TASK' : 'UPDATE TASK',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 60, horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),

                    //TITLE PART

                    child: TextFormField(
                      initialValue: _title,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(
                          fontSize: 18,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (input) {
                        return input.isEmpty ? 'Please enter a title' : null;
                      },
                      onSaved: (input) => _title = input,
                    ),
                  ),

                  //PRIORITY PART

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: DropdownButtonFormField(
                      value: _priority,
                      isDense: true,
                      icon: Icon(Icons.arrow_drop_down_circle),
                      iconSize: 22,
                      iconEnabledColor: Theme.of(context).primaryColor,
                      items: _priorities.map(
                        (String priority) {
                          return DropdownMenuItem(
                            value: priority,
                            child: Text(
                              priority,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        labelText: 'Priority',
                        labelStyle: TextStyle(
                          fontSize: 18,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: validatePriority,
                      onChanged: (value) {
                        setState(() {
                          _priority = value;
                        });
                      },
                    ),
                  ),

                  //ADD BUTTON PART

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: FlatButton(
                      child: Text(
                        widget.task == null ? 'Add' : 'Update',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      onPressed: _submit,
                    ),
                  ),
                  widget.task != null
                      ? Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: FlatButton(
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            onPressed: _delete,
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String validatePriority(input) {
    return input.isEmpty ? 'Please select a priority level' : null;
  }
}
