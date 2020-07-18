import 'package:TodoApp/models/classes/task.dart';
import 'package:TodoApp/models/global.dart';
import 'package:TodoApp/models/widgets/intary_todo_widget.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/material/reorderable_list.dart';
// import 'package:flutter/material.dart';
// import 'package:todoapp/bloc/blocs/user_bloc_provider.dart';
// import 'package:todoapp/models/classes/task.dart';
// import 'package:todoapp/models/global.dart';
// import 'package:todoapp/models/widgets/intray_todo_widget.dart';

class IntrayPage extends StatefulWidget {
  @override
  _IntrayPageState createState() => _IntrayPageState();
}

class _IntrayPageState extends State<IntrayPage> {
  List<Task> taskList = [];

  @override
  Widget build(BuildContext context) {
    taskList = getList();
    return Container(
      color: darkGrey,
      child: _buildReorderableListSimple(context),
      // child: ReorderableListView(
      //   padding: EdgeInsets.only(top: 300),
      //   children: todoItems ,
      //   onReorder: _onReorder,
      // ),
    );
  }

  Widget _buildListTile(BuildContext context, Task item) {
    return ListTile(
      key: Key(item.taskid),
      title: IntrayTodo(
        title: item.title,
      ),
    );
  }

  Widget _buildReorderableListSimple(BuildContext context) {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.transparent
      ),
      child: ReorderableListView(
        padding: EdgeInsets.only(top: 300.0),
        children:
          taskList.map((Task item) => _buildListTile(context, item)).toList(),
          onReorder: (oldIndex, newIndex) {
            setState(() {
              Task item = taskList[oldIndex];
              taskList.remove(item);
              taskList.insert(newIndex, item);
            });
          },
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }

      final Task item = taskList.removeAt(oldIndex);
      taskList.insert(newIndex, item);
    });
  }

  List<Task> getList() {
    for (int i = 0; i < 10; i++) {
      taskList.add(new Task(
        title: 'My first ' + i.toString(),
        completed: false,
        taskid: i.toString()));
    }
    return taskList;
  }
}
