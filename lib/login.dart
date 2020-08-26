import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bezierContainer.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


//  invoiceNumber = '2323',
 var customerName ='',customerAddress= '',invoiceNum = '',paymentInfo='',quotationHeading='';
 var dateSet= '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}';
  
  var itemName,customerDefault,quantity,price,itemDes='',poNo='',vendorNo= '1008879',payeeName='',discount=0.0,advancedPay=0.0,payment='',services='',validity='',warranty='';
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
  Widget cusName(String title) {
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
                customerName = val.trim();
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
  Widget cusAdd(String title) {
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
            maxLines: 3,
            controller: cAddressController,
              onChanged: (val){
                setState(() {
                  customerAddress = val.trim();
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
  Widget invoiceField(String title) {
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
                  invoiceNum = val.trim();
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

  Widget quotationHead(String title) {
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
                  quotationHeading = val.trim();
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
  Widget poNum(String title) {
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
                  poNo= val.trim();
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
  Widget vendor(String title) {
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
                  vendorNo = val.trim();
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
  var dateController = TextEditingController();


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
          'Generate',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }



  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'PCS ',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'Office',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: ' Automation',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        cusName("Customer Name"),
        cusAdd("Customer Address"),
        invoiceField("$type Number"),
        quotationHead("Heading"),
        poNum("PO. NO."),

        //vendor("Vendor Num")
      ],
    );
  }




  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          type = "Invoice";
      break;
      case 1:
      type = "Quotation";
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Radio(
                          value: 0,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        new Text(
                          'Invoice',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          value: 1,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        new Text(
                          'Quotation',
                          style: new TextStyle(
                            fontSize: 16.0,
                          ),
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment:  MainAxisAlignment.spaceAround,
                      children: [
                        Text('Customer',style: TextStyle(fontSize: 20),),
                        DropdownButton(
                            value: customerDefault,
                            hint: Text('Customer Name'),
                            items: [
                              DropdownMenuItem(
                                child: Text("Siam City (INSEE)"),
                                value: 'siam',
                              ),
                              DropdownMenuItem(
                                child: Text("Ecocycle (INSEE)"),
                                value: 'eco',
                              ),
                              DropdownMenuItem(
                                  child: Text("Other"),
                                  value: 'other'
                              )
                            ],
                            onChanged: (value) {
                              if(value=='siam')  {
                                cNameController.text = 'Siam City Cement (Lanka) Limited';
                                cAddressController.text = 'No 413,R. A. De Mel Mawatha, Colombo 03\nColombo 00300,\n117800800';
                                setState(() {
                                  customerName = 'Siam City Cement (Lanka) Limited';
                                  customerAddress = 'No 413,R. A. De Mel Mawatha, Colombo 03\nColombo 00300,\n117800800';
                                });
                              }
                              else if(value=='eco') {
                                cNameController.text = 'INSEE Ecocycle Lanka (Private) Limited';
                                cAddressController.text = 'No 413,R A De Mel Mawatha,\nColombo 00300,\n117800800';
                                setState(() {
                                  customerName = 'INSEE Ecocycle Lanka (Private) Limited';
                                  customerAddress = 'No 413,R A De Mel Mawatha,\nColombo 00300,\n117800800';
                                });
                              }
                              else {
                                cNameController.clear();
                                cAddressController.clear();
                              }

                              setState(() {
                                customerDefault= value;
                              });
                            }),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _emailPasswordWidget(),
                    CheckboxListTile(
                      title: Text("Vendor"),
                      value: vendorBool,
                      onChanged: (newValue) {
                        if(newValue) vendorNo = '1008879';
                        else vendorNo = '';
                        setState(() {
                          vendorBool = newValue;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Items',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Total Rs.$totalPrice',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                        'Item Name',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                        itemName !='other' ? DropdownButton(
                            value: itemName,
                            hint: Text('Item Name'),
                            items: [
                              DropdownMenuItem(
                                child: Text("Camera"),
                                value: 'Camera',
                              ),
                              DropdownMenuItem(
                                child: Text("IP Camera"),
                                value: 'IP Camera',
                              ),
                              DropdownMenuItem(
                                  child: Text("DVR"),
                                  value: 'DVR'
                              ),
                              DropdownMenuItem(
                                  child: Text("NVR"),
                                  value: 'NVR'
                              ),
                              DropdownMenuItem(
                                child: Text("Hard Disk"),
                                value: 'Hard Disk',
                              ),
                              DropdownMenuItem(
                                child: Text("Switch"),
                                value: 'Switch',
                              ),
                              DropdownMenuItem(
                                  child: Text("Monitor"),
                                  value: 'Monitor'
                              ),
                              DropdownMenuItem(
                                  child: Text("TV"),
                                  value: 'TV'
                              ),
                              DropdownMenuItem(
                                child: Text("Mouse"),
                                value: 'Mouse',
                              ),
                              DropdownMenuItem(
                                child: Text("DVR rack"),
                                value: 'DVR rack',
                              ),
                              DropdownMenuItem(
                                  child: Text("Wire"),
                                  value: 'Wire'
                              ),
                              DropdownMenuItem(
                                  child: Text("Accessories"),
                                  value: 'Accessories'
                              ),
                              DropdownMenuItem(
                                child: Text("Hardware Bill"),
                                value: 'Hardware Bill',
                              ),
                              DropdownMenuItem(
                                child: Text("Technician"),
                                value: 'Technician',
                              ),
                              DropdownMenuItem(
                                  child: Text("Labour"),
                                  value: 'Labour'
                              ),
                              DropdownMenuItem(
                                  child: Text("Other"),
                                  value: 'other'
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                itemName = value;
                              });
                            }):
                        Container(
                          width: 200,
                          child: TextField(
                            onChanged: (value){
                              setState(() {
                                itemNameOther=value.trim();
                              });
                            },
                          ),
                        ),
                      ],
                  ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quantity',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        quantity !='other' ? DropdownButton(
                            value: quantity,
                            hint: Text('Quantity'),
                            items: [
                              DropdownMenuItem(
                                child: Text("1"),
                                value: '1',
                              ),
                              DropdownMenuItem(
                                child: Text("2"),
                                value: '2',
                              ),
                              DropdownMenuItem(
                                  child: Text("3"),
                                  value: '3'
                              ),
                              DropdownMenuItem(
                                  child: Text("Other"),
                                  value: 'other'
                              )
                            ],
                            onChanged: (value) {
                              setState(() {
                                quantity = value;
                              });
                            }):
                        Container(
                            width: 150,
                            child: TextField(
                              onChanged: (value){
                                setState(() {
                                  quantityOther = value.trim();
                                });
                              },
                            )),
                      ],
                  ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Container(
                              width: 250,
                              child: TextField(
                                onChanged: (value){
                                  setState(() {
                                    itemDes=value.trim();
                                  });
                                },
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Container(
                              width: 200,
                              child: TextField(
                                onChanged: (value){
                                  setState(() {
                                    price=value.trim();
                                  });
                                },
                              )),
                        ],
                      ),
                    ),


                    //Add Reset button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          child: Text('Reset'),
                        onPressed: (){
                            setState(() {
                              itemName='Camera';
                              quantity='1';
                              //totalPrice= 0;
                            });
                        },),
                        RaisedButton(
                          child: Text('Add'),
                          onPressed: (){


                          },
                        ),
                      ],
                    ),
                    //Discount
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Discount %',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Container(
                              width: 100,
                              child: TextField(
                                onChanged: (value){
                                  setState(() {
                                    discount=double.parse(value);
                                  });
                                },
                              )),
                        ],
                      ),
                    ),
                    //Advanced
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Advanced Payment',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Container(
                              width: 200,
                              child: TextField(
                                onChanged: (value){
                                  setState(() {
                                    advancedPay = double.parse(value);
                                  });
                                },
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          checkbox("Validity Payment", validityBool),
                          Container(
                              width: 100,
                              child: TextField(
                                onChanged: (value){
                                  setState(() {
                                    validity = value.trim();
                                  });
                                },
                              )),
                          Text(
                            'Days',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          checkbox("Payment", paymentBool),
                          Container(
                              width: 100,
                              child: TextField(
                                onChanged: (value){
                                  setState(() {
                                    payment = value.trim();
                                  });
                                },
                              )),
                          Text(
                            '%',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          checkbox("Service", serviceBool),
                          Container(
                              width: 100,
                              child: TextField(
                                onChanged: (value){
                                  setState(() {
                                    services = value.trim();
                                  });
                                },
                              )),
                          Text(
                            'Years',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          checkbox("Warranty", warrantyBool),
                          Container(
                              width: 100,
                              child: TextField(
                                onChanged: (value){
                                  setState(() {
                                    warranty = value.trim();
                                  });
                                },
                              )),
                          Text(
                            'Years',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * .14),
                    _submitButton(),
                    SizedBox(height: height * .14),
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

  Widget checkbox(String title, bool boolValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
          value: boolValue,
          onChanged: (bool value) {
            setState(() {
              switch (title) {
                case "Validity Payment":
                  validityBool = value;
                  break;
                case "Payment":
                  paymentBool = value;
                  break;
                case "Service":
                  serviceBool = value;
                  break;
                case "Warranty":
                  warrantyBool = value;
                  break;
              }
            });
          },
        ),
        Text(title,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
      ],
    );
  }
}