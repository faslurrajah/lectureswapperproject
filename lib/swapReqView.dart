import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SwapReqView extends StatefulWidget {
  @override
  _SwapReqViewState createState() => _SwapReqViewState();
}

// ignore: camel_case_types
class _SwapReqViewState extends State<SwapReqView> {

  var courseID="EC6020";
  var courseName="Software Engineering";
  var lectName="Ms.Yaalini B";

  var courseIDRec="EC6030";
  var courseNameRec="Embedded";
  var lectNameRec="Ms.Mathuranthaga S";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        body: Container(
          color: Color(0xFF1D2136),
          child: Center(
            child: Column(        //Main Column
//              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Row(          //First row for "From" and "to" text
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Column(     //Column for text "From"
//                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text("From"),
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 30.0,
                          color: Color(0xFF8D8E98),
                          alignment: Alignment.center,
                        )
                      ],
                    ),

                    Column(     //Column for text "To"
//                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text("To"),
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 30.0,
                          color: Color(0xFF8D8E98),
                          alignment: Alignment.center,
                        )
                      ],
                    )
                  ],
                ),

                SizedBox(
                  height: 10.0,
                ),

                Row(        //Row for sender and receiver details
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SenderRecieverColumn(id: courseID,subject: courseName,nameLec: lectName),
                    Column(
                      children: [
                        SizedBox(
                          width: 10.0,
                        )
                      ],
                    ),
                    SenderRecieverColumn(id: courseIDRec,subject: courseNameRec,nameLec: lectNameRec)
                  ],
                ),

                SizedBox(
                  height: 10.0,
                ),

                Column(     //Column for buttons
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(      //Accept button row
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: (){
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
                    Row(      //Reject button row
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: (){
                            //TODO: Rejecting function
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

                )//button column end
              ],
            ),
          ),
        ),
      )),
    );
  }






  Container SenderRecieverColumn({var id, var subject, var nameLec}) {     //Columns for getting sender and reciever details
    return Container(
      color: Color(0xFF8D8E98),
      child: Column(       //Sender Column
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        Row(        //ID row
                          children: [
                            Column(   //Title column
                              children: [
//                                Text("ID: ")
                              CircleAvatar(
                                radius: 10.0,
                                backgroundImage:AssetImage('images/book.png'),
                                backgroundColor: Color(0xFF8D8E98),
                              )
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: 7.0,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(id)
                              ],
                            )
                          ],
                        ),
                        Row(      //Subject Row
                          children: [
                            Column(
                              children: [
//                                Text("Module: ")
                                CircleAvatar(
                                  radius: 10.0,
                                  backgroundImage:AssetImage('images/module.png'),
                                  backgroundColor: Color(0xFF8D8E98),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: 7.0,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(subject)
                              ],
                            ),


                          ],
                        ),
                        Row(      //Lecturer row
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
//                                    Text("Lecturer: ")
//                                    Icon(Icons.person_outline)
                                    CircleAvatar(
                                      radius: 10.0,
                                      backgroundImage:AssetImage('images/lecturer.png'),
                                      backgroundColor: Color(0xFF8D8E98),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      width: 7.0,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(nameLec)
                                  ],
                                )
                              ],
                            )
                          ],
                        )

                      ],
                    ),
    );
  }
}
