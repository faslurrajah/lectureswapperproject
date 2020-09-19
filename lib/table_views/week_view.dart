import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_database/firebase_database.dart';

import 'CustomTabView.dart';

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
  Map selectedSlots = {};

  TabController _tabController;
  List days=[
    '21','22','23','24','25','28','29'
  ];
  DatabaseReference ref;
  Map dayData = { "1" : "Mon", "2" : "Tue", "3" : "Wed", "4" : "Thur", "5" : "Fri", "6" : "Sat", "7" : "Sun" };
  DateTime date = DateTime(2020,9,20);
  List<Widget> singleTabData=new List();
  @override
  void initState() {
    ref = FirebaseDatabase.instance.reference();
    ref.once().then((value) {
      Map val= value.value;
      Map swaps=val['changes']['swaps'];

      //print(swaps);

      setState(() {
        coursesInDay = val['basicTimeTable'];
        swaps.forEach((key, value) {
          Map swapData=value;

          print(coursesInDay['${dayData[DateTime(2020,9,swapData['Fday']).weekday.toString()]}']);
        });

      });
      //print(value.value);
    });
    //print(dayData[date.weekday.toString()]);

    // TODO: implement initState
    super.initState();

  }
  Widget daySlot(int index){
    return Column(
      children: [
        slot(coursesInDay[dayData[DateTime(2020,9,int.parse(days[index])).weekday.toString()]]['slot1'],index),
        slot(coursesInDay[dayData[DateTime(2020,9,int.parse(days[index])).weekday.toString()]]['slot2'],index),
        slot(coursesInDay[dayData[DateTime(2020,9,int.parse(days[index])).weekday.toString()]]['slot3'],index),
        slot(coursesInDay[dayData[DateTime(2020,9,int.parse(days[index])).weekday.toString()]]['slot4'],index),
        slot(coursesInDay[dayData[DateTime(2020,9,int.parse(days[index])).weekday.toString()]]['slot5'],index),
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
  Widget slot(Map slotData,int index){
    return  FlatButton(
       onPressed: !isSwapSelected ? (){
        showSlotAlert(slotData);
      }:(){
         setState(() {
           selectedSlots['select']=slotData['id'];
           selectedSlots['selectDay']=days[index];
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
                          selectedSlots['own'] = slotData['id'];
                          selectedSlots['ownDay'] = days[index];

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

                    },
                      child: Text("Empty")),
                )
              ],
            )
        ):null;
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: !isSwapSelected && selectedSlots.isEmpty ? Colors.blue: selectedSlots['own']==slotData['id'] ? Colors.green: selectedSlots['select']==slotData['id'] && selectedSlots['selectDay']==days[index] ? Colors.red:Colors.blueGrey,
                border: Border.all(
                  width: 1, //                   <--- border width here
                ),
            ),
            height: 80,
            width: 150,
            child: Center(
              child: Text(slotData['id']),
            ),
          ),
          // isSwapSelected ? Positioned(
          //   width: 20,
          //     height: 20,
          //     child: Checkbox(value: true, onChanged: null),
          //   right: 2,
          //   top: 2,
          // ):SizedBox(),
        ],
      ),
    );
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

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          second<days.length && first<days.length ?Expanded(child: dayModel(first)):SizedBox(),
          second<days.length && first<days.length ? Expanded(child: dayModel(second)):SizedBox(),
        ],
      ),
    );
  }
  Widget dayModel(int index){
    return Column(
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
                  Radius.circular(5.0)
              ),
            ),
            child: Center(child: Text('${dayData[DateTime(2020,9,int.parse(days[index])).weekday.toString()]},${days[index]}',style: TextStyle(fontSize: 20),))),
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
                  //initPosition: 0,
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
