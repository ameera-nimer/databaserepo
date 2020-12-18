import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabbar/task_model.dart';

import 'db_helper.dart';


class AllTaskWidget extends StatefulWidget{
  Task task ;
   Function function;
  AllTaskWidget(this.task , [this.function]);
  @override
  _AllTaskWidgetState createState() => _AllTaskWidgetState();
}

class _AllTaskWidgetState extends State<AllTaskWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
return Card(
  margin: EdgeInsets.all(10),
  child :Padding(
    padding: EdgeInsets.symmetric(horizontal :  15),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Row(
           children: [
             Checkbox(
             value: widget.task.isComplete, 
             onChanged: (value){
                Task task = Task(widget.task.taskName ,value );
                DBHelper.dbHelper.updateTask(task);
                this.widget.task.isComplete=!this.widget.task.isComplete;
                setState(() {});
                widget.function();
       }),IconButton(
                 icon: Icon(Icons.delete),
                 iconSize: 24.0,
                 color: Colors.grey,
                 onPressed: (){
                   Task task = Task(widget.task.taskName ,widget.task.isComplete );
                   DBHelper.dbHelper.deleteTask(task);
                   this.widget.task.isComplete=!this.widget.task.isComplete;
                   setState(() {});
                   widget.function();
                   },
               ),
           ],
         ),
       
       Text(widget.task.taskName),
      
],),
  ));  }
}