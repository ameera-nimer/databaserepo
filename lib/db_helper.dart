import 'package:tabbar/task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tabbar/task_model.dart';

class DBHelper {
  DBHelper._();
  static DBHelper dbHelper = DBHelper._();
  static final String databaseName = 'tasksDb.db';
  static final String tableName = 'tasks';
  static final String taskIdColumnName = 'id';
  static final String taskNameColumnName = 'name';
  static final String taskIsCompleteColumnName = 'isComplete';

  Database database;
  Future<Database> initDatabase() async {
    if (database == null) {
      // لو لسه ما تم انشاء الداتابيز
      return await createDatabase();
    } else {
      return database;
    }
  }

  Future<Database> createDatabase() async {
    // Get a location using getDatabasesPath
    try {
      var databasesPath =
          await getDatabasesPath(); //المكان اللي راح يتخزن فيه الداتابيز
      //String path = databasesPath + '/demo.db';
      String path =
          join(databasesPath, databaseName); //دمج بين سترينغ عشان يطلع path

      //اول ما ينشئ الداتابيز ينشئ الجدول و الاعمدة-------------------------------------------------
      Database database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          db.execute('''CREATE TABLE $tableName(
            $taskIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
            $taskNameColumnName TEXT NOT NULL,
            $taskIsCompleteColumnName INTEGER
          )''');
        },
      ); //بتفحص هل يوجد داتابيز بالمسار او لا openDatabase
      return database;
    } on Exception catch (e) {
      print(e);
    }
  }

  insertNewTask(Task task) async {
    try {
      database =
          await initDatabase(); //لحتى أتاكد انه الداتابيز موجوده واعمل اتصال
      int x = await database.insert(
          tableName, task.toJson()); //رقم الصف اللي تم انشاؤه
      print(x);
    } on Exception catch (e) {
      print(e);
    }
  }
    List<Task> tasks = [];
    
  Future<List<Task>> selectAllTasks() async {
    try {
      database = await initDatabase();
      List<Map> result = (await database.query(tableName));
       List<Task> allTask= result.map((e) => Task.fromJson(e)).toList();      

      //result.forEach((row) => print(row.entries.elementAt(1)));
      //tasks.add(Task(row.entries.elementAt(1).toString() , row.entries.elementAt(2) as bool))
      print(result);
      return allTask ;
    } on Exception catch (e) {
      print(e);
      return null ;
    }
  }

  Future<List<Task>> selectSpecificTask(int isCom) async {
    try {
      database = await initDatabase();
      List<Map> result = await database
         .query(tableName, where: '$taskIsCompleteColumnName = ?', whereArgs: [isCom]);
      List<Task> SpecificTask= result.map((e) => Task.fromJson(e)).toList(); 
          

          
      print("nnnn ${result}");
      return SpecificTask ;
    } on Exception catch (e) {

      print(e);
      return null ;
    }
  }

  updateTask(
    Task task,
  ) async {
    try {
      database = await initDatabase();
      int result = await database.update(tableName, task.toJson(),
          where: '$taskNameColumnName=?', whereArgs: [task.taskName]);
      print(result);
    } on Exception catch (e) {
      print(e);
    }
  }

  deleteTask(Task task) async {
    try {
      database = await initDatabase();
      //database.delete(tableName); //بحذف كل الجدول
      int result = await database.delete(tableName, //برجع كم صف انحذف
          where: '$taskNameColumnName=?',
          whereArgs: [task.taskName]);
      print(result);
    } on Exception catch (e) {
      print(e);
    }
  }

  deleteAllTask() async {
    try {
      database = await initDatabase();
      //database.delete(tableName); //بحذف كل الجدول
      int result = await database.delete(tableName, //برجع كم صف انحذف
          );
      print(result);
    } on Exception catch (e) {
      print(e);
    }
  }
}
