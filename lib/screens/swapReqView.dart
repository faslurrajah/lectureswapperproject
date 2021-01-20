import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lectureswapperproject/data/Data.dart';
import 'package:lectureswapperproject/screens/week_view.dart';

class SwapReqView extends StatefulWidget {
  @override
  _SwapReqViewState createState() => _SwapReqViewState();
}

// ignore: camel_case_types
class _SwapReqViewState extends State<SwapReqView> {
  var courseID = "EC6020";
  var courseName = "Software Engineering";
  var lectName = "Ms.Yaalini B";

  var courseIDRec = "EC6030";
  var courseNameRec = "Embedded";
  var lectNameRec = "Ms.Mathuranthaga S";

  var courseIDRec1 = "EC6020";
  var courseNameRec1 = "Operating Systems";
  var lectNameRec1 = "Ms.Pratheepa J";

  var courseID1 = "EC6100";
  var courseName1 = "Robotics Automati";
  var lectName1 = "Mr.Sangar S";


  Map data ={};
  List keys = [];
  loading(){
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: new Text("Processing"),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoActivityIndicator(),
          ),
        )
    );
  }

  DatabaseReference ref = FirebaseDatabase.instance.reference();
  getData(){
    print(Data.empNo);
    ref.child('userdata').child('lecturers').child(Data.empNo).child('requests').child('swaps').once().then((value) {
      print(value.value);
      data = value.value;
      if(data!=null) {
        data.forEach((key, value) {
          setState(() {
            keys.add(key);
          });
        });
      }
    });
  }

  Widget tile(index){
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25)
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              //Main Column
//              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  //First row for "From" and "to" text
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Container(
                      child: Text("From",
                          style: TextStyle(
                              fontWeight: FontWeight.bold)),
                      width:
                      MediaQuery.of(context).size.width * 0.4,
                      height: 30.0,
                      color: Color(0xfffbb448),
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    senderRecieverColumn(
                        id: data[keys[index]]['ownCode'],
                        subject: data[keys[index]]['ownName'],
                        nameLec: data[keys[index]]['ownNameL'],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Text(
                        "To",
                        style:
                        TextStyle(fontWeight: FontWeight.bold),
                      ),
                      width:
                      MediaQuery.of(context).size.width * 0.4,
                      height: 30.0,
                      color: Color(0xfffbb448),
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    senderRecieverColumn(
                      id: data[keys[index]]['selectCode'],
                      subject: data[keys[index]]['selectName'],
                      nameLec: data[keys[index]]['selectNameL'],
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  //Column for buttons
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      //Accept button row
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: () {
                            loading();
                            ref.child('dept').child(Data.selectedDept)
                                .child('sem${Data.selectedSem}').child('changes')
                                .child('swaps').child(keys[index]).set(data[keys[index]]).then((value) {
                              ref.child('userdata').child('lecturers').child(Data.empNo).child('requests').child('swaps').child(keys[index]).set(null);
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (context) => WeekView()));
                            });
                            //TODO: Accepting function
                          },
                          child: Row(
                            children: [
                              Icon(Icons.done),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text("Accept"),
                            ],
                          ),
                          color: Colors.green[600],
                        ),
                      ],
                    ),
                    Row(
                      //Reject button row
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: () {
                            loading();
                            ref.child('userdata').child('lecturers').child(Data.empNo).child('requests').child('swaps').child(keys[index]).set(null);
                            Navigator.of(context).pop();
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) => SwapReqView()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.clear),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text("Decline"),
                            ],
                          ),
                          color: Colors.red[600],
                        ),
                      ],
                    )
                  ],
                ) //button column end
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffbb448),
          title: Container(
            child: Text(
              'Swaps',
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: keys.length,
            itemBuilder: (context,index){
              return tile(index);
            }),
      ),
    ));
  }

  Container senderRecieverColumn({var id, var subject, var nameLec}) {
    //Columns for getting sender and reciever details
    return Container(
      //color: Color(0xFFffffff),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1, //                   <--- border width here
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //Sender Column
          mainAxisAlignment: MainAxisAlignment.spaceAround,
//                      mainAxisSize: MainAxisSize.min,

          children: [
            Row(
              //ID row
              children: [
                CircleAvatar(
                  radius: 10.0,
                  backgroundImage: AssetImage('images/book.png'),
                  backgroundColor: Color(0xFF8D8E98),
                ),
                SizedBox(
                  width: 7.0,
                ),
                Text(id, style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              //Subject Row
              children: [
                CircleAvatar(
                  radius: 10.0,
                  backgroundImage: AssetImage('images/module.png'),
                  backgroundColor: Color(0xFF8D8E98),
                ),
                SizedBox(
                  width: 7.0,
                ),
                Text(subject, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              //Lecturer row
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10.0,
                      backgroundImage: AssetImage('images/lecturer.png'),
                      backgroundColor: Color(0xFF8D8E98),
                    ),
                    SizedBox(
                      width: 7.0,
                    ),
                    Text(nameLec, style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
