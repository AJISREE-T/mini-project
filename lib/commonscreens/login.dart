import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/admin/adminhome.dart';
import 'package:trashcan/collectingagent/agenthome.dart';
import 'package:trashcan/commonscreens/forgotpw.dart';
import 'package:trashcan/user/userhome.dart';
import 'package:trashcan/validate/validate.dart';
import 'package:trashcan/common/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _loginkey = new GlobalKey<FormState>();
  TextEditingController usernameInputcontroller = new TextEditingController();
  TextEditingController passwordInputcontroller = new TextEditingController();
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
                        height: 15,
                      ),
                      Text(
                        "Welcome!",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Sign in and get started",
                        style: TextStyle(
                          fontSize: 18,
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
                          labelText: "Username", //label
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
                            borderRadius: BorderRadius.circular(20),
                            //for rounded border
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
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          width: 200,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_loginkey.currentState!.validate()) {
                                if (usernameInputcontroller.text ==
                                        'admin@gmail.com' &&
                                    passwordInputcontroller.text ==
                                        '12345678') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AdminHome()));
                                } else {
                                  FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: usernameInputcontroller.text
                                              .trim(),
                                          password: passwordInputcontroller.text
                                              .trim())
                                      .then((user) => FirebaseFirestore.instance
                                              .collection('Login')
                                              .doc(user.user!.uid)
                                              .get()
                                              .then((value) {
                                                print("HII");
                                            if (value.data()!['type'] ==
                                                    'Collecting Agent' &&
                                                value.data()!['status'] == 1) {
                                              FirebaseFirestore.instance
                                                  .collection(
                                                      'Collecting Agent')
                                                  .doc(value.data()!['uid'])
                                                  .get()
                                                  .then((value) {
                                                    print("HII");
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AgentHome(
                                                              uid:
                                                                  value.data()![
                                                                      'uid'],
                                                              fullname: value
                                                                      .data()![
                                                                  'fullname'],
                                                              address: value
                                                                      .data()![
                                                                  'address'],
                                                              place:
                                                                  value.data()![
                                                                      'place'],
                                                              pincode: value
                                                                      .data()![
                                                                  'pincode'],
                                                              phone_no: value
                                                                      .data()![
                                                                  'phone_no'],
                                                            )));
                                              });
                                            } else if (value.data()!['type'] ==
                                                    'User' &&
                                                value.data()!['status'] == 1) {
                                              print('ok');
                                              FirebaseFirestore.instance
                                                  .collection('User')
                                                  .doc(value.data()!['uid'])
                                                  .get()
                                                  .then((value) {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            UserHome(
                                                              uid:
                                                                  value.data()![
                                                                      'uid'],
                                                              fullname: value
                                                                      .data()![
                                                                  'fullname'],
                                                              address: value
                                                                      .data()![
                                                                  'address'],
                                                              place:
                                                                  value.data()![
                                                                      'place'],
                                                              pincode: value
                                                                      .data()![
                                                                  'pincode'],
                                                              phone_no: value
                                                                      .data()![
                                                                  'phone_no'],
                                                            )));
                                              });
                                            }
                                          }).catchError((e) => showsnackbar(
                                                  "Login Failed!")));
                                }
                              }
                            },
                            child: Text(
                              "Sign In",
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
                        height: 35,
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResetPage()));
                        },
                        child: Text(
                          "Forgot password ?",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blueAccent,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  showsnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.black12,
    ));
  }
}
