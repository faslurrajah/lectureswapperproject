import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_database/firebase_database.dart';

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
    ref.child('basicTimeTable').once().then((value) {
      setState(() {
        coursesInDay = value.value;
        for(int i=0;i<days.length;i=i+2){
          setState(() {
            singleTabData.add(
                singleTabView(i)
            );
          });
        }
        _tabController = TabController(length: 4, vsync: this);
      });
      print(value.value);
    });
    //print(dayData[date.weekday.toString()]);

    // TODO: implement initState
    super.initState();

  }
  Widget daySlot(int index){
    return Column(
      children: [
        slot(coursesInDay[dayData[DateTime(2020,9,int.parse(days[index])).weekday.toString()]]['slot1']),
        slot(coursesInDay[dayData[DateTime(2020,9,int.parse(days[index])).weekday.toString()]]['slot2']),
        slot(coursesInDay[dayData[DateTime(2020,9,int.parse(days[index])).weekday.toString()]]['slot3']),
        slot(coursesInDay[dayData[DateTime(2020,9,int.parse(days[index])).weekday.toString()]]['slot4']),
        slot(coursesInDay[dayData[DateTime(2020,9,int.parse(days[index])).weekday.toString()]]['slot5']),
        slot1(coursesInDay[dayData[DateTime(2020,9,int.parse(days[index])).weekday.toString()]]['slot6']),
        slot1(coursesInDay[dayData[DateTime(2020,9,int.parse(days[index])).weekday.toString()]]['slot7']),
        // slot1(tempDaySub['slot8']),
        // slot(tempDaySub['slot9']),
        // slot(tempDaySub['slot10']),
        // slot(tempDaySub['slot1']),
        // slot(tempDaySub['slot1']),
      ],
    );
  }
  Widget slot(Map slotData){
    return FlatButton(
      onPressed: (){

      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue,
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
    int temp = index+1;
    return SingleChildScrollView(

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(child: dayModel(index)),
          temp<days.length ? Expanded(child: dayModel(temp)):SizedBox(),
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
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Time Table'),
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
                child: TabBarView(
                  controller: _tabController,
                  children: singleTabData,
                  // children: [
                  //   singleTabView(),
                  //   singleTabView(),
                  //   singleTabView(),
                  // ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
