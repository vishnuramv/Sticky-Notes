import 'package:TodoApp/models/global.dart';
import 'package:flutter/material.dart';

class IntrayTodo extends StatelessWidget {
  final String title;
  final String keyValue;
  final String note;
  IntrayTodo({this.title,this.note, this.keyValue});
  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(keyValue),
      height: 100.0,
      // margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: blue,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            new BoxShadow(
              color: Colors.black,
              blurRadius: 10.0,
            ),
          ]),
      child: Row(
        children: <Widget>[
          Radio(onChanged: null,groupValue: null,value: null,),
          Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 18.0),),
              Text(
                title,
                style: darkTodoTitle,
              ),
              // Text(
              //   note,
              //   style: darkTodoTitle,
              // )
            ],
          )
        ],
      ),
    );
  }
}
