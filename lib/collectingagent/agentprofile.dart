import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/validate/validate.dart';
import 'package:trashcan/common/colors.dart';

class ProfilePage extends StatefulWidget {
  var uid;
  var fullname;
  var address;
  var place;
  var pincode;
  var phone_no;
  ProfilePage({Key? key,this.uid,this.fullname,this.address,this.place,this.pincode,this.phone_no}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
            "Your Profile",
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
                      Text(
                        "Your Profile",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.50,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Collecting Agent')
                                .where('uid', isEqualTo: widget.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              // return ListView.builder(
                              //     itemCount: snapshot.data!.docs.length,
                              //     itemBuilder: (context, index) {
                              //
                              //
                              //
                              //       if(snapshot.hasData && snapshot.data!.docs.length==0){
                              //
                              //
                              //         return Center(
                              //           child: Text("No Profile data"),
                              //         );
                              //       }
                              //
                              //       if (!snapshot.hasData)
                              //         return Center(child: CircularProgressIndicator());

                                    return Container(


                                      child: Column(
                                        children: [
                                          SizedBox(height: 50),
                                          TextFormField(
                                            controller: fullnameInputcontroller,
                                            //controller: passwordInputcontroller,
                                            //keyboardType: TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                              labelText: " Full Name", //label
                                              //hintText: "abc@gmail.com",//hint for how to type
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(
                                                    20), //for rounded border
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
                                            controller:addressInputcontroller,
                                            maxLines: 4,
                                            //controller: passwordInputcontroller,
                                            keyboardType: TextInputType.multiline,
                                            decoration: InputDecoration(
                                              labelText: "Address", //label

                                              //hintText: "abc@gmail.com",//hint for how to type
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(
                                                    20), //for rounded border
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
                                                borderRadius: BorderRadius.circular(
                                                    20), //for rounded border
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
                                        ],
                                      ),
                                    );
                                  // });
                            },
                          )),




                      SizedBox(
                        height: 20,
                      ),

                      Container(
                          width: 200,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_registerkey.currentState!.validate()) {
                                FirebaseFirestore.instance
                                    .collection('Collecting Agent')
                                    .doc(widget.uid)
                                    .update({
                                  'fullname': fullnameInputcontroller.text,
                                  'address': addressInputcontroller.text,
                                  'phone_no':
                                  phoneInputcontroller.text.trim(),
                                }).then((value) {
                                  showsnackbar("Updated Successfully!");

                                  Navigator.pop(context);
                                }).catchError((e) => showsnackbar(
                                    "Registration Failed!"));
                                showsnackbar("Updated Successfully!");
                              }
                              //important

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
