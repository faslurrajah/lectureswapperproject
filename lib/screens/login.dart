import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lectureswapperproject/data/Data.dart';
import 'package:lectureswapperproject/screens/dashboard.dart';
import 'package:lectureswapperproject/screens/deptSelector.dart';
import 'package:lectureswapperproject/screens/week_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/bezierContainer.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user ;
  DatabaseReference ref= FirebaseDatabase.instance.reference();
  Map userList={};
  var type = 'Staff';
  int _radioValue = 0;
  String newPass='';
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  staffSubmitLogin(userInfo){
    {
      Data.email = emailController.text;
      Data.name = userInfo['name'];
      Data.dept = userInfo['dept'];
      Data.empNo = userInfo['empNo'];
      Data.type = type;
      Data.isLogged = true;

      SharedPreferences.getInstance().then((value) {
        value.setBool('logged', true);
        value.setString('email', emailController.text);
        value.setString('name', userInfo['name']);
        value.setString('dept', userInfo['dept']);
        value.setString('empNo', userInfo['empNo']);
        value.setString('type', type);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.push(
            context, MaterialPageRoute(
            builder: (context) => DeptSelector()));
      });
    }
  }

  void _signInWithEmailAndPassword() async {
    //bool userFound = false;
    loading();
    try {
       user = (await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )).user;
        if(user!=null) {
          print("${user.email} signed in");
          if (type == 'Staff') {
            ref.child('userdata').child('lecturers').once().then((value) async {
              userList = value.value;
              var isUserDataFound = false;
              userList.forEach((key, value) {
                print(value);
                Map userInfo = value;
                if (userInfo.containsValue(user.email)) {
                  isUserDataFound = true;
                  print('user Found');
                  if(userInfo['first']=='yes') {
                    Navigator.pop(context);
                    newPassword(userInfo);
                  }
                  else {
                    staffSubmitLogin(userInfo);
                  }

                }
                else {
                  //Navigator.of(context,rootNavigator: true).pop();
                  //print('user data not found');
                  }

              });
              if(!isUserDataFound) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User not found')));

              }
            });
          }
          else if(type == 'Student') {
            ref.child('userdata').child('students').once().then((value) async {
              userList = value.value;
              var isUserDataFound = false;
              userList.forEach((key, value) {
                print(value);
                Map userInfo = value;
                if (userInfo.containsValue(user.email)) {
                  isUserDataFound = true;
                  print('user Found');
                  Data.email = emailController.text;
                  Data.name = userInfo['name'];
                  Data.dept = userInfo['dept'];
                  Data.index = userInfo['index'];
                  Data.sem = userInfo['sem'];
                  Data.type = type;
                  //Data.empNo = userInfo['empNo'];
                  Data.isLogged = true;

                  SharedPreferences.getInstance().then((value) {
                    value.setBool('logged', true);
                    value.setString('email', emailController.text);
                    value.setString('name', userInfo['name']);
                    value.setString('dept', userInfo['dept']);
                    value.setString('index', userInfo['index']);
                    value.setString('sem', userInfo['sem']);
                    value.setString('type', type);
                    //value.setString('empNo', userInfo['empNo']);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Data.selectedDept = Data.dept;
                    Data.selectedSem = Data.sem;
                    Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context) => WeekView()));
                  });
                }


                else {
                //   Navigator.of(context).pop();
                //   print('user data not found');
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User not found')));
                 }
              });
              if(!isUserDataFound) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User not found')));

              }
            });
          }
        }

    } catch (e) {
      Navigator.of(context).pop();
      print(e.runtimeType);
    }
  }
  // For email input
  Widget userMail(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: emailController,
              onChanged: (val){
                setState(() {
//                customerName = val.trim();
                  //TODO: Email ID
                });
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }
  //Field for user password
  Widget userPass(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              maxLines: 1,
              controller: passwordController,
              onChanged: (val){
                setState(() {
//                  customerAddress = val.trim();
                  //TODO: inserting password
                });
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }
  loading(){
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: new Text("Checking Credentials"),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoActivityIndicator(),
          ),
        )
    );
  }

  newPassword(userInfo){
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: new Text("Set a new password"),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CupertinoTextField(
                  onChanged: (val){
                    newPass = val.trim();

                    },
                ),
                CupertinoButton(child: Text('Submit & Continue'), onPressed: (){
                  Navigator.pop(context);
                  staffSubmitLogin(userInfo);
                  _auth.currentUser.updatePassword(newPass);
                  ref.child('userdata').child('lecturers').child(Data.empNo).child('first').set('no');
                  ref.child('userdata').child('lecturers').child(Data.empNo).child('pass').set(newPass);

                })
              ],
            ),
          ),
        )
    );
  }

  error(error){
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: new Text("Checking Credentials"),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(error),
          ),
        )
    );
  }

  Widget _submitButton() {
    return FlatButton(
      onPressed: () {
        print(type);

        _signInWithEmailAndPassword();

        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => DeptSelector()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'LogIn',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Lecture ',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'Swapper \n',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: '& \n',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: ' Notifier',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        userMail("Email ID"),
        userPass("Password"),
      ],
    );
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          type = "Staff";
          break;
        case 1:
          type = "Student";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body:  Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),

                    //Staff or student selection.
                    //Should be automated in future
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Radio(
                          value: 0,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        new Text(
                          'Staff',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          value: 1,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        new Text(
                          'Student',
                          style: new TextStyle(
                            fontSize: 16.0,
                          ),
                        ),

                      ],
                    ),


                    _emailPasswordWidget(),
                    SizedBox(height: height * .1),
                    _submitButton(),
                    SizedBox(height: height * .1),
                    //_loginAccountLabel(),
                  ],
                ),
              ),
            ),
            //Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}