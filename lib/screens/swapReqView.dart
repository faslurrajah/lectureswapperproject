import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(

        appBar: AppBar(
          centerTitle:true,
            backgroundColor:Color(0xfffbb448),
            title: Container(
          child: Text('Swaps',style: TextStyle(fontSize: 25 ,color: Colors.black),),
        )
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1, //                   <--- border width here
                    ),
                  ),
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
                          Row(
                            //First row for "From" and "to" text
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Column(
                                //Column for text "From"
//                      mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text("From",style: TextStyle(fontWeight: FontWeight.bold)),
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    height: 30.0,
                                    color: Color(0xfffbb448),
                                    alignment: Alignment.center,
                                  )
                                ],
                              ),
                              Column(
                                //Column for text "To"
//                      mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text("To",style: TextStyle(fontWeight: FontWeight.bold),),
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    height: 30.0,
                                    color: Color(0xfffbb448),
                                    alignment: Alignment.center,
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            //Row for sender and receiver details
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SenderRecieverColumn(
                                  id: courseID, subject: courseName, nameLec: lectName),
                              SizedBox(
                                width: 10.0,
                              ),
                              SenderRecieverColumn(
                                  id: courseIDRec,
                                  subject: courseNameRec,
                                  nameLec: lectNameRec)
                            ],
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
                          ) //button column end
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1, //                   <--- border width here
                    ),
                  ),
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
                          Row(
                            //First row for "From" and "to" text
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Column(
                                //Column for text "From"
//                      mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text("From",style: TextStyle(fontWeight: FontWeight.bold)),
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    height: 30.0,
                                    color: Color(0xfffbb448),
                                    alignment: Alignment.center,
                                  )
                                ],
                              ),
                              Column(
                                //Column for text "To"
//                      mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text("To",style: TextStyle(fontWeight: FontWeight.bold),),
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    height: 30.0,
                                    color: Color(0xfffbb448),
                                    alignment: Alignment.center,
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            //Row for sender and receiver details
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SenderRecieverColumn(
                                    id: courseID1, subject: courseName1, nameLec: lectName1),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: SenderRecieverColumn(
                                    id: courseIDRec1,
                                    subject: courseNameRec1,
                                    nameLec: lectNameRec1),
                              )
                            ],
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
                          ) //button column end
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1, //                   <--- border width here
                    ),
                  ),
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
                          Row(
                            //First row for "From" and "to" text
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Column(
                                //Column for text "From"
//                      mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text("From",style: TextStyle(fontWeight: FontWeight.bold)),
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    height: 30.0,
                                    color:Color(0xfffbb448),
                                    alignment: Alignment.center,
                                  )
                                ],
                              ),
                              Column(
                                //Column for text "To"
//                      mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text("To",style: TextStyle(fontWeight: FontWeight.bold),),
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    height: 30.0,
                                    color: Color(0xfffbb448),
                                    alignment: Alignment.center,
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            //Row for sender and receiver details
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SenderRecieverColumn(
                                  id: courseID, subject: courseName, nameLec: lectName),
                              SizedBox(
                                width: 10.0,
                              ),
                              SenderRecieverColumn(
                                  id: courseIDRec,
                                  subject: courseNameRec,
                                  nameLec: lectNameRec)
                            ],
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
                          ) //button column end
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Container SenderRecieverColumn({var id, var subject, var nameLec}) {
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
                Text(id,style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(height: 5,),
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
                Text(subject,style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 5,),
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
                    Text(nameLec,style: TextStyle(fontWeight: FontWeight.bold))
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
