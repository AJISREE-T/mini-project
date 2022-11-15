import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/collectingagent/quote.dart';
import 'package:trashcan/common/colors.dart';
class OrderDet extends StatefulWidget {
  var price;
  var pname;
  var pid;
  var uid;
  var fullname;
  var address;
  var place;
  var pincode;
  var phone_no;
  var tid;

  int? orderStats;
  OrderDet({Key? key,this.pname,this.orderStats,this.tid,this.pid,this.price,this.uid,this.fullname,this.address,this.place,this.pincode,this.phone_no}) : super(key: key);

  @override
  _OrderDetState createState() => _OrderDetState();
}

class _OrderDetState extends State<OrderDet> {

  bool agree=false;
  var ostatus;
  String ?stat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Order Details",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xff01579b),
        elevation: 22,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.elliptical(20, 30)),
          side: BorderSide(
            width: 4,
            color: Color(0xff8bc34a),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: GestureDetector(
                        onTap: () {


                        },
                        child: Container(
                          height: 430,
                          child: Card(
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(

                                        child: Text('User Name: ',
                                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),


                                        ),
                                      ),
                                      Expanded(

                                        child: Text(widget.fullname,
                                          style:  TextStyle(fontSize: 18) ,


                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height:10,),
                                  Row(
                                    children: [
                                      Expanded(

                                        child: Text('Address: ',
                                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),


                                        ),
                                      ),
                                      Expanded(

                                        child: Text(widget.address,
                                          style:  TextStyle(fontSize: 18) ,


                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height:10,),
                                  Row(
                                    children: [
                                      Expanded(

                                        child: Text('Pin Code: ',
                                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),


                                        ),
                                      ),
                                      Expanded(

                                        child: Text(widget.pincode,
                                          style:  TextStyle(fontSize: 18) ,


                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height:10,),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text('Category: ',
                                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),


                                        ),
                                      ),
                                      Expanded(
                                        child: Text(widget.pname,
                                          style: TextStyle(fontSize: 18,),),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height:10,),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text('Price: ',
                                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),


                                        ),
                                      ),
                                      Expanded(
                                        child: Text(widget.price,
                                          style: TextStyle(fontSize: 18,),),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height:10,),
                               widget.orderStats==0  ? Expanded(
                                    child: ListTile(
                                      leading: Radio(
                                        value:"Packed",
                                        groupValue: stat,
                                        onChanged: (value){
                                          setState(() {
                                            stat=value as String? ;
                                            ostatus=1;
                                          });
                                        },
                                      ),
                                      title: Text("Packed"),
                                    ),
                                  ):   widget.orderStats==1  ? Expanded(
                                 child: ListTile(
                                   leading: Radio(
                                     value:"Shipped",
                                     groupValue: stat,
                                     onChanged: (value){
                                       setState(() {
                                         stat=value as String? ;
                                         ostatus=2;
                                       });
                                     },
                                   ),
                                   title: Text("Shipped"),
                                 ),
                               ):widget.orderStats==2 ?Expanded(
                                 child: ListTile(
                                   leading: Radio(
                                     value:"Delivered",
                                     groupValue: stat,
                                     onChanged: (value){
                                       setState(() {
                                         stat=value as String? ;
                                         ostatus=3;
                                       });
                                     },
                                   ),
                                   title: Text("Delivered"),
                                 ),
                               ):Text("") ,


                              widget.orderStats!=3?    Container(
                                      width: 150,
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance.collection('Order').doc( widget.tid).update({

                                            'ostatus': ostatus,


                                          }).then((value)

                                          {
                                            showsnackbar("Status updated!");
                                            Navigator.pop(context);

                                          });

                                        },
                                        child: Text(
                                          "Update",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: Color(0xff01579b),
                                            side: BorderSide(
                                              color: Color(0xff64dd17),
                                              width: 2,
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12))),
                                      )):Text("Order Delivered",style: TextStyle(color: Colors.green,fontSize: 22),),
                                ],
                              ),
                            ),
                          ),
                        ),

                      ),

                    ),


            ),



          ],


        ),

      ),
    );
  }
  showsnackbar(String msg)
  {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Colors.black12,

        )
    );
  }
}
