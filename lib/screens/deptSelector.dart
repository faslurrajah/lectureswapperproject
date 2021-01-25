import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lectureswapperproject/data/Data.dart';
import 'package:lectureswapperproject/main.dart';
import 'package:lectureswapperproject/screens/dashboard.dart';
import 'package:lectureswapperproject/screens/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class DeptSelector extends StatefulWidget {
  @override
  _DeptSelectorState createState() => _DeptSelectorState();
}

class _DeptSelectorState extends State<DeptSelector> {
  var semester='6';
  // Replace with server token from firebase console settings.
  final String serverToken = 'AAAAbA8_L_E:APA91bE8-2r1czJYzpHSSKI0AzCzZ8MPWfZWXpEpejavuHsvDX0KCAJXWXeaRKq_TIxzm8R-rhyLPn0V2Mp4CpgOYlrWbG0aEmlD-p7oZ-qqyxxwv7_9unBQmYBTt9F9A8ZYcJUAWFOS';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    Data.selectedSem=semester;
    super.initState();
  }
  Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
    );

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'this is a body',
            'title': 'this is a title'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': await firebaseMessaging.getToken(),
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
    Completer<Map<String, dynamic>>();

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );

    return completer.future;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Departments'),
              PopupMenuButton<int>(
                onSelected: (val){
                  print(val);
                  if(val==1) {
                    SharedPreferences.getInstance().then((value) {
                      value.clear();
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => Splash()));

                    });
                  }
                },
                icon: Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Text("Logout"),

                  ),
                ],
              ),
            ],
          ),
          backgroundColor: Color(0xfffbb448),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
                    onPressed: (){
                      sendAndRetrieveMessage();

                    },
                      child: Text(Data.name,style: GoogleFonts.yeonSung(fontSize: 20,fontWeight: FontWeight.bold),)),
                  SizedBox(height: 10,),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: semester,
                      hint: Text('Select a semester',style: GoogleFonts.sairaExtraCondensed(fontSize: 20),),
                      items: [
                        DropdownMenuItem(
                          child: Text("1st sem",style: TextStyle(fontSize: 20),),
                          value: '1',

                        ),
                        DropdownMenuItem(
                          child: Text("2nd sem",style: TextStyle(fontSize: 20),),
                          value: '2',
                        ),
                        DropdownMenuItem(
                            child: Text("3rd sem",style: TextStyle(fontSize: 20),),
                            value: '3'
                        ),
                        DropdownMenuItem(
                            child: Text("4th sem",style: TextStyle(fontSize: 20),),
                            value: '4'
                        ),
                        DropdownMenuItem(
                            child: Text("5th sem",style: TextStyle(fontSize: 20),),
                            value: '5'
                        ),
                        DropdownMenuItem(
                            child: Text("6th sem",style: TextStyle(fontSize: 20),),
                            value: '6'
                        ),
                        DropdownMenuItem(
                            child: Text("7th sem",style: TextStyle(fontSize: 20),),
                            value: '7'
                        ),
                        DropdownMenuItem(
                            child: Text("8th sem",style: TextStyle(fontSize: 20),),
                            value: '8'
                        )
                      ],

                      onChanged: (value){
                        //TODO: Action for onchange semester
                        setState(() {
                          semester=value;
                          Data.selectedSem=semester;
                          print(Data.selectedSem);
                        });
                      },

                    ),
                  ),
                ],
              ),
              SizedBox(height: 60,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  deptContainer('Computer','assets/comp.png'),
                  deptContainer('EEE','assets/eee.png')
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  deptContainer('Civil','assets/civil.png'),
                  deptContainer('Mechanical','assets/mech.png')
                ],
              ),
              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
  Widget deptContainer(deptName,url){
    var dep='';
    return Expanded(
      flex: 1,
      child: FlatButton(
        onPressed: (){
          setState(() {
            if(deptName=='Computer') Data.selectedDept='ce';
            else if(deptName=='EEE') Data.selectedDept='eee';
            else if(deptName=='Civil') Data.selectedDept='cve';
            else if(deptName=='Mechanical') Data.selectedDept='me';
          });
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Dashboard()));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(url),),
                    Text(deptName),
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
}
