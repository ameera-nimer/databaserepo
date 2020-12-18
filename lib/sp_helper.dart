
import 'package:shared_preferences/shared_preferences.dart';


class SpHelper {
  SpHelper._(); //private constructor
  static SpHelper spHelper = SpHelper._();
  SharedPreferences sharedPreferences;
  initSharedPrefrences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  writeSomethingToSharedPrefrences(String name, int age, bool isMale) {
    sharedPreferences.setString('name', name);
    sharedPreferences.setInt('age', age);
    sharedPreferences.setBool('isMale', isMale);
  }

  Map getUserData() {
    String name = sharedPreferences.getString('name');
    int age = sharedPreferences.getInt('age');
    bool isMale = sharedPreferences.getBool('isMale');
    return {'name': name, 'age': age, 'isMale': isMale};
  }
}
