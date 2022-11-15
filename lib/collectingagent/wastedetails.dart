import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/collectingagent/quote.dart';
import 'package:trashcan/common/colors.dart';
class UserWaste extends StatefulWidget {
  var uid;
  var fullname;
  var address;
  var place;
  var pincode;
  var phone_no;
  var userid;
  var username;
  var uaddress;
  var userplace;
  var userpincode;
  var wasteid;
  var wastetype;
  var wastedesc;
  UserWaste({Key? key,this.uid,
    this.fullname,
    this.address,
    this.place,
    this.pincode,
    this.phone_no,
    this.userid,this.username,this.uaddress,this.userplace,this.userpincode,this.wasteid,this.wastetype,this.wastedesc}) : super(key: key);

  @override
  _UserWasteState createState() => _UserWasteState();
}

class _UserWasteState extends State<UserWaste> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "User Details",
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
            Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: GestureDetector(
                          onTap: () {


                          },
                          child: Container(
                            height: 350,
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

                                          child: Text(widget.username,
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
                                          child: Text(widget.wastetype,
                                            style: TextStyle(fontSize: 18,),),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height:10,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text('Description: ',
                                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),


                                          ),
                                        ),
                                        Expanded(
                                          child: Text(widget.wastedesc,
                                            style: TextStyle(fontSize: 18,),),
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
                                          child: Text(widget.userpincode,
                                            style: TextStyle(fontSize: 18,),),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height:20,),
                                    Row(
                                      children: [
                                        Expanded(

                                          child: Text('Adress: ',
                                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),


                                          ),
                                        ),
                                        Expanded(

                                          child: Text(widget.uaddress,
                                            style:  TextStyle(fontSize: 18) ,


                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height:20,),

                                    Container(
                                        width: 150,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => QuotePage(
                                                      userid: widget.userid,
                                                      username:  widget.username,
                                                      uaddress:  widget.uaddress,
                                                      userplace:  widget.userplace,
                                                      userpincode:  widget.userpincode,
                                                      wasteid:  widget.wasteid,
                                                      wastetype:  widget.wastetype,
                                                      wastedesc:  widget.wastedesc,
                                                        uid: widget.uid,fullname: widget.fullname,address: widget.address,
                                                        phone_no: widget.phone_no,
                                                        place: widget.place,pincode: widget.pincode



                                                    )));
                                          },
                                          child: Text(
                                            "Add Quote",
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
                                        )),
                                  ],
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
}
