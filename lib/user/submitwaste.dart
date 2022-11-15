import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/validate/validate.dart';
import 'package:trashcan/common/colors.dart';
import 'package:uuid/uuid.dart';

class SubmitWaste extends StatefulWidget {
  var uid;
  var fullname;
  var address;
  var place;
  var pincode;
  var phone_no;
   SubmitWaste({Key? key,this.uid,this.fullname,this.address,this.place,this.pincode,this.phone_no}) : super(key: key);

  @override
  _SubmitWasteState createState() => _SubmitWasteState();
}

class _SubmitWasteState extends State<SubmitWaste> {
  var _registerkey = new GlobalKey<FormState>();
  TextEditingController pinInputcontroller = new TextEditingController();
  TextEditingController wastedesInputcontroller = new TextEditingController();
  String? categ;
  var waste_id;
  var uuid = Uuid();
  @override
  initState() {
    pinInputcontroller.text=widget.pincode;
    waste_id = uuid.v1();

    super.initState();
    // Add listeners to this class


  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Submit Waste",
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
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height*0.75,
            margin: EdgeInsets.all(20),
            child: Card(
              elevation: 5.0,
              child: Form(
                key: _registerkey,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            "Submit Waste",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,

                            ),
                          ),
                          SizedBox(height: 50),
                          DropdownButtonFormField<String>(
                            value: categ,
                            decoration: InputDecoration(
                              hintText: "Choose Category",

                              // prefixIcon: Icon(Icons.email),
                              //suffixIcon: Icon(Icons.panorama_fish_eye),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onChanged: (crs) => setState(() => categ = crs!),
                            validator: (value) =>
                                value == null ? 'field required' : null,
                            items: [
                              'Ewastes',
                              'Plastic wastes',
                              'Bio Wastes',

                              'Other'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: wastedesInputcontroller,
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
                            controller: pinInputcontroller,
                            //controller: passwordInputcontroller,
                            //keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: " Pin Code", //label
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
                                  //important
                                  if (_registerkey.currentState!.validate()) {
                                    FirebaseFirestore.instance.collection('Ewaste').doc(waste_id).set({
                                      'wid': waste_id,
                                      'wtype': categ,
                                      'description': wastedesInputcontroller.text,
                                      'pincode': pinInputcontroller.text,
                                      'userid':widget.uid,
                                      'uname':widget.fullname,
                                      'uaddress':widget.address,
                                      'uplace':widget.place,
                                      'status': 1,
                                      'agentacceptstatus':0,
                                      'agentpickedstatus':0,
                                      'completestatus':0,
                                      'useracceptstatus':0,
                                      'date': DateTime.now()


                                    }).then((value){
                                      showsnackbar("Successfully Submitted!");
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

                        ],
                      ),
                    ),
                  ),
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
