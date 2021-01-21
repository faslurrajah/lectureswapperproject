import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lectureswapperproject/data/Data.dart';
import 'package:lectureswapperproject/screens/week_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/bezierContainer.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {


//  invoiceNumber = '2323',

 var dateSet= '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}';

  var semesterSel='6',department='ce';
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.reference();


 String type = 'Invoice',email='',pass='',passC='',name='';
 int _radioValue = 0;



  var cNameController = TextEditingController();
  var cAddressController = TextEditingController();

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
            controller: cNameController,
            onChanged: (val){
              setState(() {
                email = val.trim();
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

 Widget userName(String title) {
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
             //controller: cNameController,
             onChanged: (val){
               setState(() {
                 name = val.trim();
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
            obscureText: true,
            maxLines: 1,
            controller: cAddressController,
              onChanged: (val){
                setState(() {
                  pass = val.trim();
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

  //Confirm Password
  Widget passConfirm(String title) {
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
            obscureText: true,
              onChanged: (val){
                setState(() {
                  passC = val.trim();
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


  Widget _submitButton() {
    return FlatButton(
      onPressed: () {
        if(email.isNotEmpty && pass.isNotEmpty && passC.isNotEmpty) {
          if(pass==passC) {
            loading();
            auth.createUserWithEmailAndPassword(email: email, password: pass).then((value) {
              print(value.user.emailVerified);
              ref.child('userdata').child('students').child(email.split('@')[0]).set(
                {
                  'name' : name,
                  'index' : email.split('@')[0],
                  'email' : email,
                  'dept' : department,
                  'sem' : semesterSel,
                  'pass' : pass
                 }
              );
              Data.email = email;
              Data.name = name;
              Data.dept = department;
              Data.index =  email.split('@')[0];
              Data.sem = semesterSel;
              Data.type = 'Student';
              //Data.empNo = userInfo['empNo'];
              Data.isLogged = true;

              SharedPreferences.getInstance().then((value) {
                value.setBool('logged', true);
                value.setString('email', email);
                value.setString('name', name);
                value.setString('dept', department);
                value.setString('index',  email.split('@')[0],);
                value.setString('sem', semesterSel);
                value.setString('type', 'Student');
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
            });
          }
          else ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Passwords mismatched')));
        }
        else ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All fields are required')));
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
          'Register',
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
        userName('Name with initial'),
        userMail("Campus Email"),
        userPass("Password"),
        passConfirm("Confirm Password"),
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

                    //Selecting semester
                    //Should appear only for students
                    Row(
                      mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Semester',style: GoogleFonts.sairaExtraCondensed(fontSize: 20),),
                        DropdownButton(
                          value: semesterSel,
                          hint: Text('Select your semester',style: GoogleFonts.sairaExtraCondensed(fontSize: 20),),
                          items: [
                            DropdownMenuItem(
                              child: Text("1st sem"),
                              value: '1',

                            ),
                            DropdownMenuItem(
                              child: Text("2nd sem"),
                              value: '2',
                            ),
                            DropdownMenuItem(
                                child: Text("3rd sem"),
                                value: '3'
                            ),
                            DropdownMenuItem(
                                child: Text("4th sem"),
                                value: '4'
                            ),
                            DropdownMenuItem(
                                child: Text("5th sem"),
                                value: '5'
                            ),
                            DropdownMenuItem(
                                child: Text("6th sem"),
                                value: '6'
                            ),
                            DropdownMenuItem(
                                child: Text("7th sem"),
                                value: '7'
                            ),
                            DropdownMenuItem(
                                child: Text("8th sem"),
                                value: '8'
                            )
                          ],

                          onChanged: (value){
                            //TODO: Action for onchange semester
                            setState(() {
                              semesterSel=value;
                            });
                          },

                        ),
                      ],

                    ) ,

                    //Selecting Department

                    Row(
                      mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Department',style: GoogleFonts.sairaExtraCondensed(fontSize: 20),),
                        DropdownButton(
                          value: department,
                          hint: Text('Select department',style: GoogleFonts.sairaExtraCondensed(fontSize: 20),),
                          items: [
                            DropdownMenuItem(
                              child: Text("Civil Engineering"),
                              value: 'cve',
                            ),
                            DropdownMenuItem(
                              child: Text("Mechanical Engineering"),
                              value: 'me',
                            ),
                            DropdownMenuItem(
                                child: Text("Electrical Engineering"),
                                value: 'eee'
                            ),
                            DropdownMenuItem(
                                child: Text("Computer Engineering"),
                                value: 'ce'
                            ),
                          ],

                          onChanged: (value){
                            //TODO: Action for onchange department selection
                            setState(() {
                              department = value;
                            });
                          },
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