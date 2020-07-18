import 'package:TodoApp/models/global.dart';
import 'package:flutter/material.dart';

class IntrayTodo extends StatelessWidget {
  final String title;
  final String keyValue;
  IntrayTodo({this.title, this.keyValue});
  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(keyValue),
      height: 100.0,
      // margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: redPink,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            new BoxShadow(
              color: Colors.black,
              blurRadius: 10.0,
            ),
          ]),
      child: Row(
        children: <Widget>[
          Radio(),
          Column(
            children: <Widget>[
              Text(
                title,
                style: darkTodoTitle,
              )
            ],
          )
        ],
      ),
    );
  }
}
