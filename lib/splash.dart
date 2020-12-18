

import 'db_helper.dart';

class splash {
 static getAllData() async{
  List<Map> list = await DBHelper.dbHelper.deleteAllTask();
  for(int i = 0 ; i<= list.length ; i++){
    var taskName  = list[i].entries.length;
    print("splash $taskName");
  }
}
}