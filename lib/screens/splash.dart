import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lectureswapperproject/data/Data.dart';
import 'package:lectureswapperproject/screens/week_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'deptSelector.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      SharedPreferences.getInstance().then((value) {

        if(value.containsKey('logged')) {
          if(Data.type == 'Staff')  Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => DeptSelector()));
          else if(Data.type == 'Student') {
            Data.selectedDept = Data.dept;
            Data.selectedSem = Data.sem;
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => WeekView()));
          }
        }
        else Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomePage()));
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffbb448),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/logo.png',height: 300,width: 400,),
          CupertinoActivityIndicator()

        ],
      ),
    );
  }
}
