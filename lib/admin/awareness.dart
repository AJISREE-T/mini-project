import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/common/colors.dart';
import 'package:trashcan/validate/validate.dart';
import 'package:uuid/uuid.dart';

class Awareness extends StatefulWidget {
  const Awareness({Key? key}) : super(key: key);

  @override
  _AwarenessState createState() => _AwarenessState();
}

class _AwarenessState extends State<Awareness> {
  var _registerkey = new GlobalKey<FormState>();
  TextEditingController subjectInputcontroller = new TextEditingController();
  TextEditingController descriptnInputcontroller = new TextEditingController();
  TextEditingController linkInputcontroller = new TextEditingController();
  var uuid = Uuid();
  var awareness_id;

  initState() {
    awareness_id = uuid.v1();

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
          "Awareness",
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
                      controller: subjectInputcontroller,
                      //controller: passwordInputcontroller,
                      //keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Subject", //label
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
                      controller: descriptnInputcontroller,
                      maxLines: 4,
                      //controller: passwordInputcontroller,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: "Description", //label

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
                      controller: linkInputcontroller,
                      //controller: passwordInputcontroller,
                      //keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Link", //label
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
                      height: 35,
                    ),
                    Container(
                        width: 150,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_registerkey.currentState!.validate()) {
                              FirebaseFirestore.instance
                                  .collection('Awareness')
                                  .doc(awareness_id)
                                  .set({
                                'aid': awareness_id,
                                'subject': subjectInputcontroller.text,
                                'descrptn': descriptnInputcontroller.text,
                                'link': linkInputcontroller.text,
                                'status': 1,
                                'date': DateTime.now()
                              }).then((value) {
                                showsnackbar("Successfully Added!");
                                Navigator.pop(context);
                              });
                            }
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
                    SizedBox(
                      width: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  showsnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.black12,
    ));
  }
}
