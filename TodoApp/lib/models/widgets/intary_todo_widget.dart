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
      // margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.only( left: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: blue,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            new BoxShadow(
              color: Colors.black,
              blurRadius: 10.0,
            ),
          ]),
      child: FlatButton(
              child: Row(
          // crossAxisAlignment: CrossAxisAlignment.end,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Radio(onChanged: null,groupValue: null,value: null,),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Padding(padding: EdgeInsets.only(top: 10.0),),
                  Container(
                    padding: EdgeInsets.only(bottom: 2),
                    // width: 300,
                    child: Text(
                      title,
                      style: darkTodoTitle,
                    ),
                  ),
                  Text(
                    note,
                    style: darkButText,
                  )
                ],
              ),
            ),
            // IconButton(icon: Icon(Icons.delete), onPressed: null,),
          ],
        ),
        // onPressed: _showTaskDialog,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                // title: new Text("Add new Task",style: darkTodoTitle,),
                content: Container(
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20, right: 10),
                  constraints: BoxConstraints.expand(height: 350),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: darkGrey),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          title,
                          style: blueTodoTitle,
                        ),
                        Text(
                          note,
                          style: whiteNoteText,
                        ),
                        FlatButton(
                          child: Text(
                            "Close",
                            style: darkButText,
                          ),
                          color: blue,
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      ],
                    ),
                ),
              );
            }
          );
        },
      ),
    );

    
  }

  
}
