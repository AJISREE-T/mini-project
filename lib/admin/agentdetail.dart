import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/validate/validate.dart';
import 'package:trashcan/common/colors.dart';

class AgentPage extends StatefulWidget {
  var uid;
  var fullname;
  var address;
  var place;
  var pincode;
  var phone_no;
  AgentPage({Key? key,this.uid,this.fullname,this.address,this.place,this.pincode,this.phone_no}) : super(key: key);

  @override
  _AgentPageState createState() => _AgentPageState();
}

class _AgentPageState extends State<AgentPage> {
  var _registerkey = new GlobalKey<FormState>();
  TextEditingController fullnameInputcontroller = new TextEditingController();
  TextEditingController addressInputcontroller = new TextEditingController();
  TextEditingController phoneInputcontroller = new TextEditingController();
  @override
  initState() {
    fullnameInputcontroller.text=widget.fullname;
    addressInputcontroller.text=widget.address;
    phoneInputcontroller.text=widget.phone_no;
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
            "Agent Profile",
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
                        controller: fullnameInputcontroller,
                        //controller: passwordInputcontroller,
                        //keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: " Full Name", //label
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
                      ), //fullname
                      SizedBox(
                        height: 20,
                      ),

                      TextFormField(
                        controller: addressInputcontroller,
                        maxLines: 4,
                        //controller: passwordInputcontroller,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: "Address", //label

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
                      ), //address
                      SizedBox(
                        height: 20,
                      ),

                      TextFormField(
                        controller: phoneInputcontroller,
                        //controller: passwordInputcontroller,
                        //keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Phone Number", //label
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
                      ), //phone
                      SizedBox(
                        height: 20,
                      ),



                      SizedBox(
                        height: 20,
                      ),

                      Row(
                        children: [
                          Container(
                              width: 150,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  //important

                                    if (_registerkey.currentState!.validate()) {
                                      FirebaseFirestore.instance.collection('Collecting Agent').doc(widget.uid).update({

                                        'fullname': fullnameInputcontroller.text,
                                        'address': addressInputcontroller.text,
                                        'phone_no': phoneInputcontroller.text.trim(),

                                      }).then((value)

                                      {
                                        showsnackbar("Updated Successfully!");
                                        Navigator.pop(context);
                                      });

                                    }


                                },
                                child: Text(
                                  "Edit",
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
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                              width: 150,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  //important
                                  if (_registerkey.currentState!.validate()) {
                                    FirebaseFirestore.instance.collection('Collecting Agent').doc(widget.uid).update({

                                      'status': 1,


                                    }).then((value)

                                    {
                                      FirebaseFirestore.instance.collection('Login').doc(widget.uid).update({

                                        'status': 1,


                                      }).then((value)

                                      {
                                        showsnackbar("Accepted");
                                        Navigator.pop(context);
                                      });
                                    });


                                  }
                                },
                                child: Text(
                                  "Accept",
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


                      //password

                      //for typing
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
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
