import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_database/firebase_database.dart';

import 'CustomTabView.dart';
import 'package:intl/intl.dart';

import 'const.dart';
import 'customDesign.dart';
import 'light_color.dart';

void main (){
  runApp(MaterialApp(home: WeekView(),));
}
class WeekView extends StatefulWidget {

  @override
  _WeekViewState createState() => _WeekViewState();
}

class _WeekViewState extends State<WeekView> with SingleTickerProviderStateMixin{
  Map tempDaySub= {
    "slot1" : {
      "id" : "EC6060",
      "name" : "Software Engineering",
      "nameL" : "Yaalini"
    },
    "slot2" : {
      "id" : "EC6010",
      "name" : "Embedded System Design",
      "nameL" : "mathuranthaga"
    },
    "slot3" : {
      "id" : "EC6020",
      "name" : "Embedded System Design",
      "nameL" : "mathuranthaga"
    },
    "slot4" : {
      "id" : "EC6030",
      "name" : "Embedded System Design",
      "nameL" : "mathuranthaga"
    },
    "slot5" : {
      "id" : "EC6040",
      "name" : "Embedded System Design",
      "nameL" : "mathuranthaga"
    },
    "slot6" : {
      "id" : "EC6050",
      "name" : "Embedded System Design",
      "nameL" : "mathuranthaga"
    },
    "slot7" : {
      "id" : "EC6060",
      "name" : "Embedded System Design",
      "nameL" : "mathuranthaga"
    }
  };
  Map coursesInDay = Map();
  bool isSwapSelected=false;
  Map selectedSlots = {}, selectedEmptySlot={},selectTakeSlot={};

  TabController _tabController;
  List formattedDate =[];
  // List days=[
  //   '21','22','23','24','25','28','29'
  // ];
  DatabaseReference ref;
  Map myLec = {
    "id": "EC9640",
    "name": "Artificial Intelligence",
    "nameL": "Ms.B.Yaalini",
    "type": "Lec"
  };
  Map dayData = { "1" : "Mon", "2" : "Tue", "3" : "Wed", "4" : "Thur", "5" : "Fri", "6" : "Sat", "7" : "Sun" };
  DateTime date = DateTime(2020,9,20);
  List<Widget> singleTabData=new List();
  @override
  void initState() {
    generateDates();
    fetchData();
    //print(dayData[date.weekday.toString()]);

    // TODO: implement initState
    super.initState();

  }

  generateDates(){
    final items = List<DateTime>.generate(60, (i) =>
        DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ).add(Duration(days: i)));
    for(int i=0;i<60;i++){

      var tempDate=DateFormat('yyyy/MM/dd').format(items[i]).split("/");
      if(DateTime(int.parse(tempDate[0]) ,int.parse(tempDate[1]),int.parse(tempDate[2])).weekday==7 || DateTime(int.parse(tempDate[0]) ,int.parse(tempDate[1]),int.parse(tempDate[2])).weekday==6){
        //print('$tempDate its sunday or saturday');
      }
      else {
        setState(() {
          formattedDate.add(DateFormat('yyyy/MM/dd').format(items[i]));
        });
      }
//      print(DateFormat('yyyy-MM-dd').format(items[i]));
    }
    for(int i=0;i<formattedDate.length;i++){
      //print(formattedDate[i]);
    }
  }
  fetchData(){
    ref = FirebaseDatabase.instance.reference();
    ref.once().then((value) {
      Map val= value.value;
      Map swaps={};

      if(val.containsKey('changes')) if(val['changes'].containsKey('swaps')) swaps=val['changes']['swaps'];
      setState(() {
        coursesInDay = val['basicTimeTable'];
        //print(coursesInDay);
      });
        if (swaps.isNotEmpty) {
        swaps.forEach((key, value) {
          //print(value);
          Map va = value;
          if(va['status']=='pending'){
            List temp=  va['ownDay'].split("/");
            String dayOwn = dayData['${DateTime(int.parse( temp[0]),int.parse( temp[1]),int.parse( temp[2])).weekday.toString()}'];
            temp=  va['selectDay'].split("/");
            String daySelected = dayData['${DateTime(int.parse( temp[0]),int.parse( temp[1]),int.parse( temp[2])).weekday.toString()}'];
            setState(() {
              print(va['ownSlotNum']);
              print(coursesInDay[dayOwn][va['ownSlotNum']]);
              coursesInDay[dayOwn][va['ownSlotNum']] = {
                'id' : va['selectCode'],
                'name':va['selectName'],
                'nameL': va['selectNameL'],
                'type' : 'S',

              };
              print(coursesInDay[dayOwn][va['ownSlotNum']]);
              print(va['selectSlotNum']);
              print(coursesInDay[daySelected][va['selectSlotNum']]);
              coursesInDay[daySelected][va['selectSlotNum']] = {
                'id' : va['ownCode'],
                'name':va['ownName'],
                'nameL': va['ownNameL'],
                'type' : 'S',

              };
              print(coursesInDay[daySelected][va['selectSlotNum']]);
            });
            //print(dayOwn);
          }
        });
      }
      Map emptySlots={};
      if(val['changes'].containsKey('empty')) emptySlots=val['changes']['empty'];
      //print(value.value);
      if (emptySlots.isNotEmpty) {
        print(emptySlots);
        emptySlots.forEach((key, value) {
          List temp=  value['day'].split("/");
          //print(temp);
          var temp1 = DateTime(int.parse( temp[0]),int.parse( temp[1]),int.parse( temp[2])).weekday.toString();
           setState(() {
             print(coursesInDay[dayData[temp1]][value['slotNum']]);
             coursesInDay[dayData[temp1]][value['slotNum']] = {
               "id": "",
               "name": "",
               "nameL": "",
               "type": "FREE"
             } ;
           });
        });
      }
      Map takeSlots={};
      if(val['changes'].containsKey('take')) takeSlots=val['changes']['take'];
      if (takeSlots.isNotEmpty) {
        print(takeSlots);
        takeSlots.forEach((key, value) {
          List temp=  value['day'].split("/");
          //print(temp);
          var temp1 = DateTime(int.parse( temp[0]),int.parse( temp[1]),int.parse( temp[2])).weekday.toString();
          setState(() {
            print(coursesInDay[dayData[temp1]][value['slotNum']]);
            coursesInDay[dayData[temp1]][value['slotNum']] = myLec ;
          });
        });
      }
    });
  }
  Widget daySlot(int index){
    List temp=  formattedDate[index].split("/");
    //print(temp);
    var temp1 = DateTime(int.parse( temp[0]),int.parse( temp[1]),int.parse( temp[2])).weekday.toString();
    return Column(
      children: [
        slot(coursesInDay[dayData[temp1]]['slot1'],index,'slot1'),
        slot(coursesInDay[dayData[temp1]]['slot2'],index,'slot2'),
        slot(coursesInDay[dayData[temp1]]['slot3'],index,'slot3'),
        slot(coursesInDay[dayData[temp1]]['slot4'],index,'slot4'),
        slot(coursesInDay[dayData[temp1]]['slot5'],index,'slot5'),
        slot(coursesInDay[dayData[temp1]]['slot6'],index,'slot6'),
        slot(coursesInDay[dayData[temp1]]['slot7'],index,'slot7'),
        // CardCourses(
        //   image: Image.asset(
        //       "assets/images/books.png", width: 5, height: 5),
        //   color: Constants.lightPink,
        //   title: "Theory Explanations",
        //   hours: "A/L Science Lessons",
        //
        // ),
        slot(coursesInDay[dayData[temp1]]['slot8'],index,'slot8'),

        //slot1(coursesInDay[dayData[DateTime(2020,9,int.parse(days[index])).weekday.toString()]]['slot6']),
        //slot1(coursesInDay[dayData[DateTime(2020,9,int.parse(days[index])).weekday.toString()]]['slot7']),
        // slot1(tempDaySub['slot8']),
        // slot(tempDaySub['slot9']),
        // slot(tempDaySub['slot10']),
        // slot(tempDaySub['slot1']),
        // slot(tempDaySub['slot1']),
      ],
    );
  }
  Widget slot(Map slotData,int index,String slotNumber){
    return  FlatButton(
       onPressed: !isSwapSelected ? (){
        showSlotAlert(slotData);
      }:(){
         setState(() {
           selectedSlots['selectCode']=slotData['id'];
           selectedSlots['selectDay']=formattedDate[index];
           selectedSlots['selectSlotNum'] = slotNumber;
           selectedSlots['selectName'] = slotData['name'];
           selectedSlots['selectNameL'] = slotData['nameL'];
           selectedSlots['selectType'] = slotData['type'];

           print(selectedSlots);
         });
       },
      onLongPress: (){
        !isSwapSelected ? showDialog(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: new Text("Select an Action"),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: CupertinoButton(
                    onPressed: (){
                        setState(() {
                          selectedSlots['ownCode'] = slotData['id'];
                          selectedSlots['ownDay'] = formattedDate[index];
                          selectedSlots['ownSlotNum'] = slotNumber;
                          selectedSlots['ownName'] = slotData['name'];
                          selectedSlots['ownNameL'] = slotData['nameL'];
                          selectedSlots['ownType'] = slotData['type'];
                          selectedSlots['status'] = "pending";



                          print(selectedSlots);
                          isSwapSelected = true;
                        });
                        Navigator.pop(context);
                    },
                      child: Text("Swap")),
                ),
                CupertinoDialogAction(
                  child: CupertinoButton(
                    onPressed: (){
                      Navigator.pop(context);
                      setState(() {
                        selectedEmptySlot = {
                          'day': formattedDate[index],
                          'slotNum': slotNumber
                        };
                        print(selectedEmptySlot);
                      });
                      confirmEmptyAlert();
                    },
                      child: Text("Empty")),
                ),
                 CupertinoDialogAction(
                  child: CupertinoButton(
                      onPressed: (){
                        setState(() {
                          selectTakeSlot = {
                            'slotNum' :slotNumber,
                            'day' : formattedDate[index]
                          };
                        });
                        selectTakeSlot.addAll(myLec);
                        print(selectTakeSlot);

                        Navigator.pop(context);
                        confirmTakeAlert();

                      },
                      child: Text("Take Slot")),
                )
              ],
            )
        ):null;
      },
      child: Container(
        decoration: BoxDecoration(
            color: !isSwapSelected && selectedSlots.isEmpty ?selectColor(slotNumber, slotData): selectedSlots['ownSlotNum']==slotNumber && selectedSlots['ownDay']==formattedDate[index] ? Colors.green: selectedSlots['selectSlotNum']==slotNumber && selectedSlots['selectDay']==formattedDate[index] ? Color.fromRGBO(218,165,32,1):Colors.blueGrey,
            border: Border.all(
              width: 0.5, //                   <--- border width here
            ),
        ),
        height: 80,
        width: 150,
        child: Center(
          child: Text('${slotData['id']}\n${slotData['name']}',textAlign: TextAlign.center,),
        ),
      ),
    );
  }
  Color selectColor(slotNumber,slotData) {
    Color color ;
    Map colors = {
      'Lec' : Color.fromRGBO(46, 193, 172,1),
      'Lab' : Color.fromRGBO(157, 101, 201,1),
      'ESU' : Color.fromRGBO(30, 95, 116,1),
      'FREE' : Color.fromRGBO(240,255,240,1),
      'GTS' : Color.fromRGBO(221,160,221,1),
      'S' : Color.fromRGBO(65,105,225, 1)
    };
    //print(slotData);
    return colors[slotData['type']];
  }
  Widget slot1(Map slotData){
    return FlatButton(
      onPressed: (){},
      child: Container(

        decoration: BoxDecoration(
            color: Colors.blueGrey,
            border: Border.all(
              width: 1, //                   <--- border width here
            )),
        height: 80,
        width: 150,
        child: Center(
          child: Text(slotData['id']),
        ),
      ),
    );
  }
  Widget timeSlot(time){
    return Container(

      decoration: BoxDecoration(
        color: Constants.lightViolet,
          border: Border.all(
            width: 1, //                   <--- border width here
          )),
      height: 80,
      width: 150,
      child: Center(
        child: Text('$time',style: TextStyle(fontSize: 12),),
      ),
    );
  }
  Widget singleTabView(int index){
    int first = index*2;
    int second = first+1;
    return SingleChildScrollView(
      physics: scroll,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 80,
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                    width: 150,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Constants.lightAccent,
                      border: Border.all(
                          width: 1.0
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(5.0) //                 <--- border radius here
                      ),
                    ),
                    child: Icon(Icons.timer,size: 30,),
                    // child: Center(child: Text('Time',style: TextStyle(fontSize: 20),),
                    // )
                ),
                SizedBox(height: 20,),
                timeSlot('8.00-9.00'),
                timeSlot('9.00-9.55'),
                timeSlot('10.10-11.05'),
                timeSlot('11.05-12.00'),
                timeSlot('1.00-1.55'),
                timeSlot('1.55-2.50'),
                timeSlot('3.10-4.05'),
                timeSlot('4.05-5.00'),


              ],
            ),
          ),
          second<formattedDate.length && first<formattedDate.length ?Expanded(child: dayModel(first)):SizedBox(),
          second<formattedDate.length && first<formattedDate.length ? Expanded(child: dayModel(second)):SizedBox(),
        ],
      ),
    );
  }
  Widget dayModel(int index){
    List temp=  formattedDate[index].split("/");
    //print(temp);
    var temp1 = DateTime(int.parse( temp[0]),int.parse( temp[1]),int.parse( temp[2])).weekday.toString();

    return Column(
      children: [
        SizedBox(height: 20,),
        Container(
          width: 150,
            height: 60,
            decoration: BoxDecoration(
              color: Constants.lightAccent,
              border: Border.all(
                  width: 1.0
              ),
              borderRadius: BorderRadius.all(
                  Radius.circular(5.0)
              ),
            ),
            child: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 5,),
                CircleAvatar(
                  radius: 12,
                  child: Text('${dayData[temp1]}',style: TextStyle(fontSize: 8)),
                ),
                SizedBox(height: 5,),
                Text('${formattedDate[index]}',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                SizedBox(height: 5,),
              ],
            ))),
        SizedBox(height: 20,),
        SingleChildScrollView(
          child: daySlot(index)
        )
      ],
    );
  }
  confirmSwapAlert() {
    return showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: new Text("Request Swapping"),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: CupertinoButton(
                  onPressed: (){
                    setState(() {
                      //isSwapSelected = true;
                    });
                    Navigator.pop(context);
                  },
                  child: Text("No")),
            ),
            CupertinoDialogAction(
              child: CupertinoButton(
                  onPressed: (){
                        ref.child('changes').child('swaps').push().set(selectedSlots);
                        fetchData();
                        setState(() {
                          isSwapSelected = false;
                          selectedSlots.clear();
                        });
                        Navigator.pop(context);

                        },
                  child: Text("Yes")),
            )
          ],
        )
    );

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Time Table'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      isSwapSelected ? FlatButton(
                          onPressed: (){
                            setState(() {
                              isSwapSelected = false;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.check,
                              color: Colors.green,
                              size: 30,
                            ),
                          )): SizedBox(),
                      isSwapSelected ? FlatButton(
                          onPressed: (){
                            setState(() {
                              isSwapSelected = false;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 30,
                            ),
                          )): SizedBox()
                    ],
                  )

                ],
              ),

            ),
            body: Row(
              children: [
                Container(
                  width: 80,
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            border: Border.all(
                                width: 3.0
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(5.0) //                 <--- border radius here
                            ),
                          ),
                          child: Center(child: Text('Time',style: TextStyle(fontSize: 20),))),
                      SizedBox(height: 20,),
                      timeSlot('8.00-9.00'),
                      timeSlot('9.00-9.55'),
                      timeSlot('10.10-11.05'),

                    ],
                  ),
                ),
                Expanded(
                  child: CustomTabView(
                    initPosition: 0,
                    itemCount: 4,
                    //tabBuilder: (context, index) => Tab(text: days[index]),
                    pageBuilder: (context, index) => singleTabView(index),
                    onPositionChange: (index){
                      //print('current position: $index');
                      //initPosition = index;
                    },
                    //onScroll: (position) => print('$position'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
  confirmEmptyAlert() {
    return showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: new Text("Confirm Emptying"),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: CupertinoButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
            ),
            CupertinoDialogAction(
              child: CupertinoButton(
                  onPressed: (){
                    ref.child('changes').child('empty').push().set(selectedEmptySlot);
                    fetchData();
                    Navigator.pop(context);
                  },
                  child: Text("Continue")),
            )
          ],
        )
    );

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Time Table'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      isSwapSelected ? FlatButton(
                          onPressed: (){
                            setState(() {
                              isSwapSelected = false;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.check,
                              color: Colors.green,
                              size: 30,
                            ),
                          )): SizedBox(),
                      isSwapSelected ? FlatButton(
                          onPressed: (){
                            setState(() {
                              isSwapSelected = false;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 30,
                            ),
                          )): SizedBox()
                    ],
                  )

                ],
              ),

            ),
            body: Row(
              children: [
                Container(
                  width: 80,
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            border: Border.all(
                                width: 3.0
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(5.0) //                 <--- border radius here
                            ),
                          ),
                          child: Center(child: Text('Time',style: TextStyle(fontSize: 20),))),
                      SizedBox(height: 20,),
                      timeSlot('8.00-9.00'),
                      timeSlot('9.00-9.55'),
                      timeSlot('10.10-11.05'),

                    ],
                  ),
                ),
                Expanded(
                  child: CustomTabView(
                    initPosition: 0,
                    itemCount: 4,
                    //tabBuilder: (context, index) => Tab(text: days[index]),
                    pageBuilder: (context, index) => singleTabView(index),
                    onPositionChange: (index){
                      //print('current position: $index');
                      //initPosition = index;
                    },
                    //onScroll: (position) => print('$position'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
  confirmTakeAlert() {
    return showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: new Text("Confirm Taking"),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: CupertinoButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
            ),
            CupertinoDialogAction(
              child: CupertinoButton(
                  onPressed: (){
                    ref.child('changes').child('take').push().set(selectTakeSlot);
                    fetchData();
                    Navigator.pop(context);
                  },
                  child: Text("Take")),
            )
          ],
        )
    );

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Time Table'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      isSwapSelected ? FlatButton(
                          onPressed: (){
                            setState(() {
                              isSwapSelected = false;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.check,
                              color: Colors.green,
                              size: 30,
                            ),
                          )): SizedBox(),
                      isSwapSelected ? FlatButton(
                          onPressed: (){
                            setState(() {
                              isSwapSelected = false;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 30,
                            ),
                          )): SizedBox()
                    ],
                  )

                ],
              ),

            ),
            body: Row(
              children: [
                Container(
                  width: 80,
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            border: Border.all(
                                width: 3.0
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(5.0) //                 <--- border radius here
                            ),
                          ),
                          child: Center(child: Text('Time',style: TextStyle(fontSize: 20),))),
                      SizedBox(height: 20,),
                      timeSlot('8.00-9.00'),
                      timeSlot('9.00-9.55'),
                      timeSlot('10.10-11.05'),

                    ],
                  ),
                ),
                Expanded(
                  child: CustomTabView(
                    initPosition: 0,
                    itemCount: 4,
                    //tabBuilder: (context, index) => Tab(text: days[index]),
                    pageBuilder: (context, index) => singleTabView(index),
                    onPositionChange: (index){
                      //print('current position: $index');
                      //initPosition = index;
                    },
                    //onScroll: (position) => print('$position'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
  showSlotAlert(Map slotData) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: new Text(slotData['id']),
          content: Column(
            children: [
              SizedBox(height: 10,),
              Text(slotData['name']),
              Text(slotData['nameL'])
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: CupertinoButton(
                  onPressed: (){
                    setState(() {
                      //isSwapSelected = true;
                    });
                    Navigator.pop(context);
                  },
                  child: Text("Exit",style: TextStyle(color: Colors.red),)),
            ),
          ],
        )
    );

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Time Table'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      isSwapSelected ? FlatButton(
                          onPressed: (){
                            setState(() {
                              isSwapSelected = false;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.check,
                              color: Colors.green,
                              size: 30,
                            ),
                          )): SizedBox(),
                      isSwapSelected ? FlatButton(
                          onPressed: (){
                            setState(() {
                              isSwapSelected = false;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 30,
                            ),
                          )): SizedBox()
                    ],
                  )

                ],
              ),

            ),
            body: Row(
              children: [
                Container(
                  width: 80,
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            border: Border.all(
                                width: 3.0
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(5.0) //                 <--- border radius here
                            ),
                          ),
                          child: Center(child: Text('Time',style: TextStyle(fontSize: 20),))),
                      SizedBox(height: 20,),
                      timeSlot('8.00-9.00'),
                      timeSlot('9.00-9.55'),
                      timeSlot('10.10-11.05'),

                    ],
                  ),
                ),
                Expanded(
                  child: CustomTabView(
                    initPosition: 0,
                    itemCount: 4,
                    //tabBuilder: (context, index) => Tab(text: days[index]),
                    pageBuilder: (context, index) => singleTabView(index),
                    onPositionChange: (index){
                      //print('current position: $index');
                      //initPosition = index;
                    },
                    //onScroll: (position) => print('$position'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
  ScrollPhysics scroll = ScrollPhysics();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(247, 209, 186,1),
          appBar: AppBar(
            backgroundColor: Color(0xfffbb448),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Time Table',style: TextStyle(fontSize: 20,color: Colors.black),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    isSwapSelected ? FlatButton(
                        onPressed: (){
                          confirmSwapAlert();
                          setState(() {
                            //isSwapSelected = false;
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 30,
                          ),
                        )): SizedBox(),
                    isSwapSelected ? FlatButton(
                        onPressed: (){
                          setState(() {
                            selectedSlots.clear();
                            isSwapSelected = false;
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 30,
                          ),
                        )): SizedBox()
                  ],
                )

              ],
            ),

          ),
          body: Row(
            children: [
              Expanded(
                child: CustomTabView(
                  //initPosition: 0,
                  itemCount: formattedDate.length~/2,
                  //tabBuilder: (context, index) => Tab(text: days[index]),
                  pageBuilder: (context, index) => singleTabView(index),
                  onPositionChange: (index){
                    //print('current position: $index');
                    //initPosition = index;
                  },
                  //onScroll: (position) => print('$position'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
