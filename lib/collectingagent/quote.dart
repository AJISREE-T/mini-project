import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trashcan/validate/validate.dart';
import 'package:trashcan/common/colors.dart';
import 'package:uuid/uuid.dart';
class QuotePage extends StatefulWidget {
  var price;
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


  QuotePage({Key? key,this.price,this.uid,this.fullname,this.address,this.place,this.pincode,this.phone_no,this.userid,this.username,this.uaddress,this.userplace,this.userpincode,this.wasteid,this.wastetype,this.wastedesc}) : super(key: key);

  @override
  _QuotePageState createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  var _registerkey = new GlobalKey<FormState>();
  TextEditingController priceInputcontroller = new TextEditingController();
  TextEditingController dateInputcontroller = new TextEditingController();
  var quoteid;
  var uuid = Uuid();
  @override
  initState() {
    quoteid = uuid.v1();

    super.initState();
    // Add listeners to this class


  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Quote",
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
        child: Form(
          key: _registerkey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: priceInputcontroller,
                      //controller: passwordInputcontroller,
                      //keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: " Price", //label
                        //hintText: "abc@gmail.com",//hint for how to type
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(20), //for rounded border
                        ),
                        //prefixIcon: Icon(Icons.email,color: Colors.blue,),
                      ),
                      validator: (value) {
                        return validate.txtvalidator(value!);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: dateInputcontroller,
                    //editing controller of this TextField
                        decoration: const InputDecoration(
                            icon: Icon(Icons.calendar_today), //icon of text field
                            labelText: "Enter Date" //label text of field
                        ),
                        readOnly: true,  // when true user cannot edit text
                        onTap: () async {
                         _showPicker();
                        },
                      validator: (value) {
                        return validate.txtvalidator(value!);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: 150,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_registerkey.currentState!.validate()) {
                              FirebaseFirestore.instance.collection('Quote').doc(quoteid).set({
                                'qid': quoteid,
                                'price': priceInputcontroller.text,
                                'collectiondate': dateInputcontroller.text,
                                'agentid':widget.uid,
                                'agentname':widget.fullname,
                                'agentaddress':widget.address,
                                'agentplace':widget.place,
                                'agentpin':widget.pincode,
                                'agentphno':widget.phone_no,
                                'userid':widget.userid,
                                'username':widget.username,
                                'uaddress':widget.uaddress,
                                'userplace':widget.userplace,
                                'userpincode':widget.userpincode,
                                'wasteid':widget.wasteid,
                                'wastetype':widget.wastetype,
                                'wastedesc':widget.wastedesc,
                                'status': 1,
                                'astatus':0,
                                'useracceptstatus':0,
                                'completestatus':0,
                                'date': DateTime.now(),
                                'datechangestatus':0,
                                'cstatus':0,


                              }).then((value) {
                                
                                FirebaseFirestore.instance.collection('Ewaste').doc(widget.wasteid).update({
'agentacceptstatus':1

                                });
                              }).
                              
                              then((value){
                                showsnackbar("Successfully Posted!");
                                Navigator.pop(context);
                              });
                            }
                            showsnackbar("Quote Submitted");
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 22,
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


  _showPicker()async{
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //get today's date
        firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101)
    );

    if(pickedDate != null ){
      print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
      print(formattedDate); //formatted date output using intl package =>  2022-07-04
      //You can format date as per your need

      setState(() {
       dateInputcontroller.text = formattedDate; //set foratted date to TextField value.
      });
    }else{
      print("Date is not selected");
    }
  }
}
