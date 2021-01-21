import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lectureswapperproject/data/Data.dart';
import 'package:lectureswapperproject/main.dart';
import 'package:lectureswapperproject/screens/dashboard.dart';
import 'package:lectureswapperproject/screens/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DeptSelector extends StatefulWidget {
  @override
  _DeptSelectorState createState() => _DeptSelectorState();
}

class _DeptSelectorState extends State<DeptSelector> {
  var semester='6';

  @override
  void initState() {
    Data.selectedSem=semester;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Departments'),
              PopupMenuButton<int>(
                onSelected: (val){
                  print(val);
                  if(val==1) {
                    SharedPreferences.getInstance().then((value) {
                      value.clear();
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => Splash()));

                    });
                  }
                },
                icon: Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Text("Logout"),

                  ),
                ],
              ),
            ],
          ),
          backgroundColor: Color(0xfffbb448),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(Data.name,style: GoogleFonts.yeonSung(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: semester,
                      hint: Text('Select a semester',style: GoogleFonts.sairaExtraCondensed(fontSize: 20),),
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
                  ),
                ],
              ),
              SizedBox(height: 60,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  deptContainer('Computer','assets/comp.png'),
                  deptContainer('EEE','assets/eee.png')
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  deptContainer('Civil','assets/civil.png'),
                  deptContainer('Mechanical','assets/mech.png')
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
      flex: 1,
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(url),),
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
