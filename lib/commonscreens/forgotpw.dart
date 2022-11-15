import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/admin/adminhome.dart';
import 'package:trashcan/collectingagent/agenthome.dart';
import 'package:trashcan/user/userhome.dart';
import 'package:trashcan/validate/validate.dart';
import 'package:trashcan/common/colors.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({Key? key}) : super(key: key);

  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  var _loginkey = new GlobalKey<FormState>();
  TextEditingController usernameInputcontroller = new TextEditingController();
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgcolor,
        body: SafeArea(
          child: Form(
            key: _loginkey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: 300,
                        child: Image.asset(
                          "assets/images/mylogo.png",
                          height: 80,
                          width: 80,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Enter your email to reset the password",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: usernameInputcontroller,
                        //controller: passwordInputcontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email", //label
                          hintText: "abc@gmail.com", //hint for how to type
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            //for rounded border
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                        ),
                        validator: (value) {
                          return validate.emailValidator(value!);
                        },
                      ), //email
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          width: 200,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_loginkey.currentState!.validate()) {
                                FirebaseAuth.instance.sendPasswordResetEmail(email: usernameInputcontroller.text.trim()).then((value) => showsnackbar('Please check your email'));


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
