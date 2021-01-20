import 'package:flutter/material.dart';
import 'package:lectureswapperproject/data/Data.dart';
import 'package:lectureswapperproject/screens/dashboard.dart';


class DeptSelector extends StatefulWidget {
  @override
  _DeptSelectorState createState() => _DeptSelectorState();
}

class _DeptSelectorState extends State<DeptSelector> {
  var semester;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Departments'),),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButton(
                value: semester,
                hint: Text('Select a semester',style: TextStyle(fontSize: 20),),
                items: [
                  DropdownMenuItem(
                    child: Text("1st sem",style: TextStyle(fontSize: 20),),
                    value: '1',

                  ),
                  DropdownMenuItem(
                    child: Text("2nd sem",style: TextStyle(fontSize: 20),),
                    value: '2',
                  ),
                  DropdownMenuItem(
                      child: Text("3rd sem",style: TextStyle(fontSize: 20),),
                      value: '3'
                  ),
                  DropdownMenuItem(
                      child: Text("4th sem",style: TextStyle(fontSize: 20),),
                      value: '4'
                  ),
                  DropdownMenuItem(
                      child: Text("5th sem",style: TextStyle(fontSize: 20),),
                      value: '5'
                  ),
                  DropdownMenuItem(
                      child: Text("6th sem",style: TextStyle(fontSize: 20),),
                      value: '6'
                  ),
                  DropdownMenuItem(
                      child: Text("7th sem",style: TextStyle(fontSize: 20),),
                      value: '7'
                  ),
                  DropdownMenuItem(
                      child: Text("8th sem",style: TextStyle(fontSize: 20),),
                      value: '8'
                  )
                ],

                onChanged: (value){
                  //TODO: Action for onchange semester
                  setState(() {
                    semester=value;
                    Data.selectedSem=semester;
                    print(Data.selectedSem);
                  });
                },

              ),
              SizedBox(height: 60,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  deptContainer('Computer','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTyf-BJmGPUtDh7K2qhYyUW0M3Y9cKXRlyjxg&usqp=CAU'),
                  deptContainer('EEE','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTyf-BJmGPUtDh7K2qhYyUW0M3Y9cKXRlyjxg&usqp=CAU')
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  deptContainer('Civil','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTyf-BJmGPUtDh7K2qhYyUW0M3Y9cKXRlyjxg&usqp=CAU'),
                  deptContainer('Mechanical','https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTyf-BJmGPUtDh7K2qhYyUW0M3Y9cKXRlyjxg&usqp=CAU')
                ],
              ),
              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
  Widget deptContainer(deptName,url){
    var dep='';
    return Expanded(
      child: FlatButton(
        onPressed: (){
          setState(() {
            if(deptName=='Computer') Data.selectedDept='ce';
            else if(deptName=='EEE') Data.selectedDept='eee';
            else if(deptName=='Civil') Data.selectedDept='cve';
            else if(deptName=='Mechanical') Data.selectedDept='me';
          });
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Dashboard()));
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: Column(
                  children: [
                    Image(
                      height: 150,
                      width: 150,
                      image: NetworkImage(url),),
                    Text(deptName),
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
}
