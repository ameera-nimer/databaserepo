import 'package:flutter/material.dart';
import 'package:tabbar/new_task.dart';
import 'package:tabbar/task_model.dart';
import 'package:tabbar/task_widget.dart';
import 'constants.dart';
import 'db_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return MaterialApp(debugShowCheckedModeBanner: false,home :TabBarPage());

  }
}

class TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      drawer: Drawer(child: Column(children: [
       UserAccountsDrawerHeader(
         currentAccountPicture: CircleAvatar(child:Text("T".toUpperCase())),
          accountName:Text("Task"),
          accountEmail:Text("task@gmail.com")),
          ListTile(
            onTap: (){
              tabController.animateTo(0);
              Navigator.pop(context);
            },
            title: Text('All Tasks '),
            subtitle: Text('All user/’s task '),
            //leading: Icon(Icons.done),
            trailing: Icon(Icons.arrow_right),),
              ListTile(
                onTap: (){
              tabController.animateTo(1);
              Navigator.pop(context);
            },
            title: Text('Complete Tasks '),
            subtitle: Text('All user/’s Complete task '),
            //leading: Icon(Icons.done),
            trailing: Icon(Icons.arrow_right),),
              ListTile(
                onTap: (){
              tabController.animateTo(2);
              Navigator.pop(context);
            },
            title: Text('Incomplete Tasks '),
            subtitle: Text('All user/’s Incomplete task '),
            //leading: Icon(Icons.done),
            trailing: Icon(Icons.arrow_right),),
       /*Text('data1'),
       Text('data2'),
       Text('data3'),*/

     ],),),
       appBar: AppBar(
         
    title:Text('Todo'), 
    bottom:TabBar(
      controller: tabController,
      tabs: [
      Tab(
        text:'all tasks ',
        
        ),
        Tab(
        text:'complete tasks ',
        ),
        Tab(
        text:'Incomplete tasks ',
        )
       
    ],isScrollable: true,) ,
    ),
       body: Column(
    //physics: NeverScrollableScrollPhysics(), // عشان ما اقدر اسحب من الوسط فقط بغير المحتوى لما اضغط على الtabs من فوق
    children: [
      Expanded(
        child: TabBarView(
          controller: tabController,
          children: [AllTasks(),CompleteTasks(),IncompleteTasks()]),
          )


      
    ],
    ),
    floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          setState(() {
             Navigator.push(context, MaterialPageRoute(builder: (context){
                return NewTask();
             },));
          });
        },
      ),
     );
  }
}

class AllTasks  extends StatefulWidget {
  
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    body:FutureBuilder<List<Task>>(
      future: DBHelper.dbHelper.selectAllTasks(),
      builder: (context  , snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
            return Container();
           
        }else if (!snapshot.hasData || snapshot.data == null){
                                  return Container();

           //List<Task> data = snapshot.data;
           //print(data);
        }else{
          List<Task> data = snapshot.data;
          return ListView.builder(
             itemCount: snapshot.data.length,
             itemBuilder: (context, index) {
               return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                       IconButton(
                        icon: Icon(Icons.delete),
                        iconSize: 24.0,
                        color: Colors.grey,
                        onPressed: (){
                            showDialog(
                              context: context,
                              builder: (context) {
                                 return Center(
                                   child: AlertDialog(
                                      title: Text("Alert"),
                                      content: Text("You Will Delete A Task , are you \n sure? "), 
                                      actions: <Widget>[
                                         FlatButton(
                                           child: Text("Ok"),
                                           onPressed: () {
                                             Task task = Task(snapshot?.data[index].taskName,snapshot?.data[index].isComplete );
                                             DBHelper.dbHelper.deleteTask(task);
                                             setState(() {});
                                           Navigator.pop(context, false);
                                           },
                                          ),
                                         FlatButton(
                                           child: Text("NO"),
                                           onPressed: () {
                                           Navigator.pop(context, true);
                                           },
                                            ),
                                            ],
                                           )
      
                                 
                                 
                                 
                                 
                                 
                                 );
                               },
                              );
                   },
               ),
       Text(snapshot?.data[index].taskName),
       Checkbox(
         value: snapshot?.data[index].isComplete , 
         onChanged: (value){
          Task task = Task(snapshot?.data[index].taskName,value );
          DBHelper.dbHelper.updateTask(task);
          snapshot?.data[index].isComplete=snapshot?.data[index].isComplete;
          setState(() {});
       }),
],);
        },
      );
        }
      }
    ,),
  ); 
  }
}

class CompleteTasks  extends StatefulWidget {
  @override
  _CompleteTasksState createState() => _CompleteTasksState();
}

class _CompleteTasksState extends State<CompleteTasks> {
   
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    body:FutureBuilder<List<Task>>(
      future: DBHelper.dbHelper.selectSpecificTask(1),
      builder: (context  , snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
            return Container();
           
        }else if (!snapshot.hasData || snapshot.data == null){
                                  return Container();

           //List<Task> data = snapshot.data;
           //print(data);
        }else{
          List<Task> data = snapshot.data;
          return ListView.builder(
             itemCount: snapshot.data.length,
             itemBuilder: (context, index) {
               return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                       IconButton(
                        icon: Icon(Icons.delete),
                        iconSize: 24.0,
                        color: Colors.grey,
                        onPressed: (){
                             showDialog(
                              context: context,
                              builder: (context) {
                                 return Center(
                                   child: AlertDialog(
                                      title: Text("Alert"),
                                      content: Text("You Will Delete A Task , are you \n sure? "), 
                                      actions: <Widget>[
                                         FlatButton(
                                           child: Text("Ok"),
                                           onPressed: () {
                                             Task task = Task(snapshot?.data[index].taskName,snapshot?.data[index].isComplete );
                                             DBHelper.dbHelper.deleteTask(task);
                                             setState(() {});
                                           Navigator.pop(context, false);
                                           },
                                          ),
                                         FlatButton(
                                           child: Text("NO"),
                                           onPressed: () {
                                           Navigator.pop(context, true);
                                           },
                                            ),
                                            ],
                                           )
      
                                 
                                 
                                 
                                 
                                 
                                 );
                               },
                              );
                   },
               ),
       Text(snapshot?.data[index].taskName),
       Checkbox(
         value: snapshot?.data[index].isComplete , 
         onChanged: (value){
          Task task = Task(snapshot?.data[index].taskName,value );
          DBHelper.dbHelper.updateTask(task);
          snapshot?.data[index].isComplete=snapshot?.data[index].isComplete;
          setState(() {});
       }),
],);
        },
      );
           print(data);
        }
      }
    ,),
  ); 
  }
}

class IncompleteTasks  extends StatefulWidget {
 
  @override
  _IncompleteTasksState createState() => _IncompleteTasksState();
}

class _IncompleteTasksState extends State<IncompleteTasks> {

  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    body:FutureBuilder<List<Task>>(
      future: DBHelper.dbHelper.selectSpecificTask(0),
      builder: (context  , snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
            return Container();
           
        }else if (!snapshot.hasData || snapshot.data == null){
                                  return Container();

           //List<Task> data = snapshot.data;
           //print(data);
        }else{
          List<Task> data = snapshot.data;
          return ListView.builder(
             itemCount: snapshot.data.length,
             itemBuilder: (context, index) {
               return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                       IconButton(
                        icon: Icon(Icons.delete),
                        iconSize: 24.0,
                        color: Colors.grey,
                        onPressed: (){

                            showDialog(
                              context: context,
                              builder: (context) {
                                 return Center(
                                   child: AlertDialog(
                                      title: Text("Alert"),
                                      content: Text("You Will Delete A Task , are you \n sure? "), 
                                      actions: <Widget>[
                                         FlatButton(
                                           child: Text("Ok"),
                                           onPressed: () {
                                             Task task = Task(snapshot?.data[index].taskName,snapshot?.data[index].isComplete );
                                             DBHelper.dbHelper.deleteTask(task);
                                             setState(() {});
                                           Navigator.pop(context, false);
                                           },
                                          ),
                                         FlatButton(
                                           child: Text("NO"),
                                           onPressed: () {
                                           Navigator.pop(context, true);
                                           },
                                            ),
                                            ],
                                           )
      
                                 
                                 
                                 
                                 
                                 
                                 );
                               },
                              );
                           
                   },
               ),
       Text(snapshot?.data[index].taskName),
       Checkbox(
         value: snapshot?.data[index].isComplete , 
         onChanged: (value){
          Task task = Task(snapshot?.data[index].taskName,value );
          DBHelper.dbHelper.updateTask(task);
          snapshot?.data[index].isComplete=snapshot?.data[index].isComplete;
          setState(() {});
       }),
],);
        },
      );
           print(data);
        }
      }
    ,),
  );
  }
}



