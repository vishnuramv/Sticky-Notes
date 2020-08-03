import 'package:TodoApp/bloc/blocs/user_bloc_provider.dart';
import 'package:TodoApp/models/classes/task.dart';
import 'package:TodoApp/models/global.dart';
import 'package:TodoApp/models/widgets/intary_todo_widget.dart';
import 'package:flutter/material.dart';

class IntrayPage extends StatefulWidget {
  final String apiKey;
  IntrayPage({this.apiKey});

  @override
  _IntrayPageState createState() => _IntrayPageState();
}

class _IntrayPageState extends State<IntrayPage> {
  List<Task> taskList = [];

  TaskBloc tasksBloc;
  

  @override
  void initState() {
    tasksBloc = TaskBloc(widget.apiKey);
  }

  @override
  void dispose() {
    // taskBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: darkGrey,
        child: StreamBuilder(
          stream: tasksBloc.getTask,
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot != null) {
              if (snapshot.data.length > 0) {
                // taskList = snapshot.data;
                return _buildReorderableListSimple(context, snapshot.data);
              } else if (snapshot.data.length == 0) {
                return Center(
                  child: Container(
                    height: 300,
                    // color: blue,
                    padding: EdgeInsets.only(left: 25,right: 25,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.all(40)),
                        Text(
                          "No Task",
                          style: TextStyle(
                              fontFamily: 'Avenir',
                              fontWeight: FontWeight.bold,
                              color:blue,
                              fontSize: 30),
                        ),
                        Text(
                          "If you have added any task, try refreshing by swiping to right and back to left...!",
                          style: TextStyle(
                              fontFamily: 'Avenir',
                              // fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Container();
              }
              return CircularProgressIndicator();
            }
          },
        ));
  }

  Widget _buildListTile(BuildContext context, Task item) {
    return ListTile(
      key: Key(item.taskId.toString()),
      title: IntrayTodo(
        title: item.title,
        note: item.note
      ),
    );
  }

  Widget _buildReorderableListSimple(
      BuildContext context, List<Task> taskList) {
    return Theme(
      data: ThemeData(canvasColor: Colors.transparent),
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




  // Future<List<Task>> getList() async {
  //   List<Task> tasks = await taskBloc.getUserTask(widget.apiKey);
  //   return tasks;
  // }
}
