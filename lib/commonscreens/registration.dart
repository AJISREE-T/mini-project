import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/validate/validate.dart';
import 'package:trashcan/common/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _registerkey = new GlobalKey<FormState>();
  TextEditingController fullnameInputcontroller = new TextEditingController();
  TextEditingController addressInputcontroller = new TextEditingController();
  TextEditingController phoneInputcontroller = new TextEditingController();
  TextEditingController placeInputcontroller = new TextEditingController();
  TextEditingController pinInputcontroller = new TextEditingController();
  TextEditingController usernameInputcontroller = new TextEditingController();
  TextEditingController passwordInputcontroller = new TextEditingController();
  bool visible = true;
  bool agree = false;
  String? type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgcolor,
        body: SafeArea(
          child: Form(
            key: _registerkey,
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
                        height: 15,
                      ),
                      Text(
                        "New Account!",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Sign up and get started",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<String>(
                        value: type,
                        decoration: InputDecoration(
                          hintText: "Register as",

                          // prefixIcon: Icon(Icons.email),
                          //suffixIcon: Icon(Icons.panorama_fish_eye),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onChanged: (crs) => setState(() => type = crs!),
                        validator: (value) =>
                            value == null ? 'field required' : null,
                        items: ['User', 'Collecting Agent']
                            .map<DropdownMenuItem<String>>((String value) {
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
                        controller: placeInputcontroller,
                        //controller: passwordInputcontroller,
                        //keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Place", //label
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
                          labelText: "Pin Code", //label
                          //hintText: "abc@gmail.com",//hint for how to type
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(20), //for rounded border
                          ),
                          //prefixIcon: Icon(Icons.email,color: Colors.blue,),
                        ),
                        validator: (value) {
                          return validate.pinvalidator(value!);
                        },
                      ),
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
                          return validate. phonevalidator(value!);
                        },
                      ), //phone
                      SizedBox(
                        height: 20,
                      ),

                      TextFormField(
                        controller: usernameInputcontroller,
                        //controller: passwordInputcontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Username", //label
                          hintText: "abc@gmail.com", //hint for how to type
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(20), //for rounded border
                          ),
                          prefixIcon: Icon(
                            Icons.email,
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
                      TextFormField(
                        controller: passwordInputcontroller,
                        obscureText: visible,
                        obscuringCharacter:
                            '*', // display * when typing password
                        //keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: "Password", //label
                          //hintText: "abc@gmail.com",//hint for how to type
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(20), //for rounded border
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  visible =
                                      !visible; // visible/invisible password
                                });
                              },
                              child: Icon(
                                visible == true
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              )),
                        ),
                        validator: (value) {
                          return validate.passwordvalidator(value!);
                        },
                      ), //pass

                      SizedBox(
                        height: 20,
                      ),
                      CheckboxListTile(
                        value: agree,
                        onChanged: (value) {
                          setState(() {
                            agree = value!;
                          });
                        },
                        title: Text("I agree Terms and Rules"),
                       // subtitle: Text("Good Job"),
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
                              if (_registerkey.currentState!.validate() && agree==true) {
                                FirebaseAuth.instance.createUserWithEmailAndPassword(email:usernameInputcontroller.text.trim(),
                                  password: passwordInputcontroller.text.trim()).then((user) {
                                    FirebaseFirestore.instance.collection('Login').doc(user.user!.uid).set({
                                      'uid': user.user!.uid,
                                      'username': usernameInputcontroller.text.trim(),
                                      'password': passwordInputcontroller.text.trim(),
                                      'status' :type=='User' ?1:0,
                                     'type':type,
                                      'date': DateTime.now()
                                    }).then((value) {
                                      FirebaseFirestore.instance.collection(type!).doc(user.user!.uid).set({
                                        'uid': user.user!.uid,
                                        'fullname': fullnameInputcontroller.text,
                                        'address': addressInputcontroller.text,
                                        'place': placeInputcontroller.text,
                                        'pincode': pinInputcontroller.text,
                                        'phone_no': phoneInputcontroller.text.trim(),
                                        'username': usernameInputcontroller.text.trim(),
                                        'password': passwordInputcontroller.text.trim(),
                                        'status' :type=='User' ?1:0,
                                        'date': DateTime.now()
                                      }).then((value)

                                      {
                                        showsnackbar("Registered Successfully!");
                                        Navigator.pop(context);
                                      }).catchError((e)=>showsnackbar("Registration Failed!"));
                                    }).catchError((e)=>showsnackbar("Registration Failed!"));
                                }).catchError((e)=>showsnackbar("Authentication Failed!"));

                              }
                              else
                                showsnackbar("Please check all fields");
                            },
                            child: Text(
                              "Sign Up",
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
