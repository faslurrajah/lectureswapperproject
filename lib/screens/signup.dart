import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/bezierContainer.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {


//  invoiceNumber = '2323',
 var customerName ='',customerAddress= '',invoiceNum = '',paymentInfo='',quotationHeading='';
 var dateSet= '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}';
  
  var itemName,semesterSel,department,quantity,price,itemDes='',poNo='',vendorNo= '1008879',payeeName='',discount=0.0,advancedPay=0.0,payment='',services='',validity='',warranty='';
  bool vendorBool=true;
  var itemNameOther, quantityOther,priceOther ;
  var totalPrice=0.0;
 var type = 'Invoice';
 int _radioValue = 0;
 bool page=true;
  bool validityBool = false;
  bool paymentBool = false;
  bool serviceBool = false;
  bool warrantyBool = false;

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

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
            controller: cAddressController,
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
              onChanged: (val){
                setState(() {
//                  invoiceNum = val.trim();
                //TODO: confirming password with previous
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
      onPressed: () {},
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
        userMail("Email ID"),
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

                    //Selecting semester
                    //Should appear only for students
                     type == 'Student' ? Row(
                      mainAxisAlignment:  MainAxisAlignment.spaceAround,
                      children: [
                        Text('Semester',style: TextStyle(fontSize: 20),),
                        DropdownButton(
                          value: semesterSel,
                          hint: Text('Select your semester'),
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

                    ) : SizedBox(height: 0,),

                    //Selecting Department

                    Row(
                      mainAxisAlignment:  MainAxisAlignment.spaceAround,
                      children: [
                        Text('Department',style: TextStyle(fontSize: 20),),
                        DropdownButton(
                          value: department,
                          hint: Text('Select department'),
                          items: [
                            DropdownMenuItem(
                              child: Text("Civil Engineering"),
                              value: 'civil',
                            ),
                            DropdownMenuItem(
                              child: Text("Mechanical Engineering"),
                              value: 'mechanical',
                            ),
                            DropdownMenuItem(
                                child: Text("Electrical Engineering"),
                                value: 'elec'
                            ),
                            DropdownMenuItem(
                                child: Text("Computer Engineering"),
                                value: 'comp'
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