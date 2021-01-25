import 'package:firebase_messaging/firebase_messaging.dart';
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
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _message = '';

  _registerOnFirebase() {
    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.getToken().then((token) => print(token));
  }
  void getMessage() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('received message $message');
          setState(() => _message = message["notification"]["body"]);
        }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      setState(() => _message = message["notification"]["body"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      setState(() => _message = message["notification"]["body"]);
    });
  }


  @override
  void initState() {
    _registerOnFirebase();
    getMessage();
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
