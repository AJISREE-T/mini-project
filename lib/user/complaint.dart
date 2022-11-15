import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/validate/validate.dart';
import 'package:trashcan/common/colors.dart';
import 'package:uuid/uuid.dart';
class ComplaintPage extends StatefulWidget {
  var uid;
  var fullname;
  var address;
  var place;
  var pincode;
  var phone_no;
  ComplaintPage({Key? key,this.uid,this.fullname,this.address,this.place,this.pincode,this.phone_no}) : super(key: key);

  @override
  _ComplaintPageState createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  var _registerkey = new GlobalKey<FormState>();
  TextEditingController comInputcontroller = new TextEditingController();
  var compid;
  var uuid = Uuid();
  @override
  initState() {

    compid = uuid.v1();

    super.initState();
    // Add listeners to this class


  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Complaint",
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
                          "Complaint",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 50),
                        TextFormField(
                          controller: comInputcontroller,
                          maxLines: 4,
                          //controller: passwordInputcontroller,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            labelText: "Your Complaint", //label

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
                          height: 30,
                        ),
                        Container(
                            width: 150,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_registerkey.currentState!.validate()) {
                                  FirebaseFirestore.instance.collection('Complaint').doc(compid).set({
                                    'cid': compid,
                                    'compdescription': comInputcontroller.text,
                                    'userid':widget.uid,
                                    'uname':widget.fullname,
                                    'solution':null,
                                    'status': 1,
                                    'date': DateTime.now()


                                  }).then((value){
                                    showsnackbar("Successfully Posted!");
                                    Navigator.pop(context);
                                  });
                                }


                              },
                              child: Text(
                                "Post",
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
