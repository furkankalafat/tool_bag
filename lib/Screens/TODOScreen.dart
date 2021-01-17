import 'package:flutter/material.dart';
import 'package:my_tool_bag/Models/Task.dart';
import 'package:my_tool_bag/Services/DbServicesTask.dart';
import 'package:my_tool_bag/Widgets/AddTODO.dart';

class TODOScreen extends StatefulWidget {
  @override
  _TODOScreenState createState() => _TODOScreenState();
}

class _TODOScreenState extends State<TODOScreen> {
  Future<List<Task>> _tasks;

  @override
  void initState() {
    super.initState();
    _refreshTaskList();
  }

  _refreshTaskList() {
    setState(() {
      _tasks = DbServicesTask.instance.getTaskList();
    });
  }

  //LIST OF TASKS

  Widget _buildTask(Task task) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        margin: EdgeInsets.all(10),
        height: 75,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.grey[300]),
        child: Center(
          child: ListTile(
              leading: Checkbox(
                onChanged: (value) {
                  task.status = value ? 1 : 0;
                  DbServicesTask.instance.updateTask(task);
                  _refreshTaskList();
                },
                activeColor: Colors.green[800],
                value: task.status == 1 ? true : false,
              ),
              title: Text(
                task.title,
                style: TextStyle(
                  fontSize: 18,
                  decoration: task.status == 0
                      ? TextDecoration.none
                      : TextDecoration.lineThrough,
                ),
              ),
              subtitle: Text(
                '${task.priority}',
                style: TextStyle(
                  fontSize: 15,
                  decoration: task.status == 0
                      ? TextDecoration.none
                      : TextDecoration.lineThrough,
                ),
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddTODO(
                            refreshTaskList: _refreshTaskList,
                            task: task,
                          )))),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        leading: IconButton(
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Yapılacaklar Listesi"),
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTODO(
                    refreshTaskList: _refreshTaskList,
                  ),
                )),
            icon: Icon(Icons.add_circle),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _tasks,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: 1 + snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return SizedBox(height: 35);
              }
              return _buildTask(snapshot.data[index - 1]);
            },
          );
        },
      ),
    );
  }
}
