import 'package:shared_preferences/shared_preferences.dart';

class Data{
  static bool isLogged=false;
  static String email;
  static String name;
  static String dept;
  static String empNo;
  static String index;
  static String sem;
  static String selectedDept;
  static String selectedSem;
  static String type;

  Data(){
    SharedPreferences.getInstance().then((value) {
      isLogged = value.getBool('logged');
      email = value.getString('email');
      name =  value.getString('name');
      dept =  value.getString('dept');
      empNo =  value.getString('empNo');
      type =  value.getString('type');
      index =  value.getString('index');
      sem =  value.getString('sem');
    });
  }


}