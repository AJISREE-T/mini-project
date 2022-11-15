import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/common/colors.dart';
import 'package:trashcan/validate/validate.dart';
class QuoteEdit extends StatefulWidget {
  var uid;
  var agentname;
  var username;
  var wastetype;
  var wasteprice;
  var colldate;

  QuoteEdit({Key? key,this.agentname,this.username,this.wastetype,this.wasteprice,this.colldate}) : super(key: key);

  @override
  State<QuoteEdit> createState() => _QuoteEditState();
}

class _QuoteEditState extends State<QuoteEdit> {
  TextEditingController dateInputcontroller = new TextEditingController();
  var _registerkey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
       return Scaffold(
        backgroundColor: bgcolor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Quotes",
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
                key:_registerkey,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: widget.wasteprice,

                            decoration: InputDecoration(
                              labelText: "Price", //label
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(20), //for rounded border
                              ),
                            ),
                            validator: (value) {
                              return validate.txtvalidator(value!);
                            },
                          ), //phone
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: widget.colldate,

                            decoration: InputDecoration(
                              labelText: "Date", //label

                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(20), //for rounded border
                              ),

                            ),
                            validator: (value) {
                              return validate.txtvalidator(value!);
                            },
                          ),



                          SizedBox(
                            height: 20,
                          ),

                          Container(
                              width: 200,
                              height: 55,
                              child: ElevatedButton(
                                onPressed: () {
                                  //important
                                  if(_registerkey.currentState!.validate()){

    FirebaseFirestore.instance.collection('User').doc(widget.uid).update({

    'collectiondate':widget.colldate,
    'price': widget.wasteprice,


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

                          //password

                          //for typing
                        ],
                      ),
                    ),
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
