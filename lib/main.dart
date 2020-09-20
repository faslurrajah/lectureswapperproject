import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lectureswapperproject/login.dart';


import 'signup.dart';

void main() {
  runApp(MaterialApp(home: WelcomePage(),));
}


class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Widget _submitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color(0xffdf8e33).withAlpha(100),
                    offset: Offset(2, 4),
                    blurRadius: 8,
                    spreadRadius: 2)
              ],
              color: Colors.white),
          child: Text(
            'Login',
            style: TextStyle(fontSize: 20, color: Color(0xfff7892b)),
          ),
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpPage()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color(0xffdf8e33).withAlpha(100),
                    offset: Offset(2, 4),
                    blurRadius: 8,
                    spreadRadius: 2)
              ],
              color: Colors.white),
          child: Text(
            'Register now',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      ),
    );
  }

//  Widget _label() {
//    return Container(
//        margin: EdgeInsets.only(top: 40, bottom: 20),
//        child: Column(
//          children: <Widget>[
//            Text(
//              'Quick login with Touch ID',
//              style: TextStyle(color: Colors.white, fontSize: 17),
//            ),
//            SizedBox(
//              height: 20,
//            ),
//            Icon(Icons.fingerprint, size: 90, color: Colors.white),
//            SizedBox(
//              height: 20,
//            ),
//            Text(
//              'Touch ID',
//              style: TextStyle(
//                color: Colors.white,
//                fontSize: 15,
//                decoration: TextDecoration.underline,
//              ),
//            ),
//          ],
//        ));
//  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Lecture',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.orange,
          ),
          children: [
            TextSpan(
              text: ' Swap',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'per',
              style: TextStyle(color: Colors.orangeAccent, fontSize: 30),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          //padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2
                )
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white,Colors.white]
              )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // Image(
              //   image: NetworkImage('https://tlgur.com/d/g05exDE4'),
              //   //height: 500,
              //   //width: 600,
              // ),
              SizedBox(
                height: 20,
              ),
              _title(),
              SizedBox(
                height: 40,
              ),
              _submitButton(),
              SizedBox(
                height: 20,
              ),
              _signUpButton(),
              SizedBox(
                height: 5,
              ),
              //_label()
            ],
          ),
        ),
      ),
    );
  }
}
