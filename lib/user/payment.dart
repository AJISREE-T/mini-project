import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/validate/validate.dart';
import 'package:trashcan/common/colors.dart';
import 'package:uuid/uuid.dart';
class PayPage extends StatefulWidget {
  var price;
  var pname;
  var desc;
  var pid;
  var uid;
  var fullname;
  var address;
  var place;
  var pincode;
  var phone_no;

  PayPage({Key? key,this.pname,this.desc,this.pid,this.price,this.uid,this.fullname,this.address,this.place,this.pincode,this.phone_no}) : super(key: key);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  var _registerkey = new GlobalKey<FormState>();
  TextEditingController priceInputcontroller = new TextEditingController();
  TextEditingController cardnoInputcontroller = new TextEditingController();
  TextEditingController pinInputcontroller = new TextEditingController();
  var pay_id;
  var uuid = Uuid();
  initState() {
    priceInputcontroller.text=widget.price;
    pay_id = uuid.v1();
    super.initState();
    // Add listeners to this class


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Payment",
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
                      readOnly: true,
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
                      controller: cardnoInputcontroller,
                      //controller: passwordInputcontroller,
                      //keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: " Card Number", //label
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
                      controller: pinInputcontroller,
                      //controller: passwordInputcontroller,
                      //keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: " Pin", //label
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
                    Container(
                        width: 150,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            FirebaseFirestore.instance.collection('Order').doc(pay_id).set({
                              'pay_id': pay_id,
                              'userid':widget.uid,
                              'uname':widget.fullname,
                              'uaddress':widget.address,
                              'pname':widget.pname,
                              'upin':widget.pincode,
                              'pid':widget.pid,
                              'desc':widget.desc,
                              'price': priceInputcontroller.text,
                              'cardno': cardnoInputcontroller.text,
                              'pin': pinInputcontroller.text,
                              'status': 1,
                              'ostatus':0,
                              'date': DateTime.now()


                            }).then((value){
                              showsnackbar("Successfully Submitted!");
                              Navigator.pop(context);
                            });
                            showsnackbar("Payment Successful!");
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
}
