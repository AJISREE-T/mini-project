import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/validate/validate.dart';
import 'package:trashcan/common/colors.dart';
import 'package:uuid/uuid.dart';
class ReplyComplaint extends StatefulWidget {
  var cid;
  ReplyComplaint({Key? key,this.cid}) : super(key: key);

  @override
  _ReplyComplaintState createState() => _ReplyComplaintState();
}

class _ReplyComplaintState extends State<ReplyComplaint> {
  var _registerkey = new GlobalKey<FormState>();
  TextEditingController comInputcontroller = new TextEditingController();
  String? type;
  var cid;
  var uuid = Uuid();
  @override
  initState() {

    cid = uuid.v1();

    super.initState();
    // Add listeners to this class


  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Reply Complaint",
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
                      controller: comInputcontroller,
                      maxLines: 4,
                      //controller: passwordInputcontroller,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: "Message", //label

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
                              FirebaseFirestore.instance.collection('Complaint').doc(widget.cid).update({
                                'solution':comInputcontroller.text,


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
