import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/collectingagent/agentprofile.dart';
import 'package:trashcan/collectingagent/userrequest.dart';
import 'package:trashcan/collectingagent/viewquote.dart';
import 'package:trashcan/common/colors.dart';
import 'package:trashcan/commonscreens/login.dart';

class AgentHome extends StatefulWidget {
  var uid;
  var fullname;
  var address;
  var place;
  var pincode;
  var phone_no;
  AgentHome({Key? key,this.uid,this.fullname,this.address,this.place,this.pincode,this.phone_no}) : super(key: key);

  @override
  _AgentHomeState createState() => _AgentHomeState();
}

class _AgentHomeState extends State<AgentHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Home",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
              onTap:(){
                FirebaseAuth.instance.signOut().then((value){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage()));

                });
              },
              child: Icon(Icons.logout)),
        ],
        backgroundColor: Color(0xff01579b),
        elevation: 22,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          side: BorderSide(
            width: 4,
            color: Color(0xff8bc34a),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all( 20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage(
                                  uid: widget.uid,fullname: widget.fullname,address: widget.address,phone_no: widget.phone_no,place: widget.place,pincode: widget.pincode
                              )));
                    },
                    child: Container(
                      height: 250,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            colors: [Colors.green, Colors.blueAccent]),
                        color: Color(0xff82b1ff),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Image.asset(
                              "assets/images/profile.png",
                              height: 120,
                              width: 120,
                            ),
                          ),
                          Center(
                            child: Text(
                              "Profile",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserReq(
                                  uid: widget.uid,fullname: widget.fullname,address: widget.address,phone_no: widget.phone_no,place: widget.place,pincode: widget.pincode

                              )));
                    },
                    child: Container(
                      height: 250,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            colors: [Colors.green, Colors.blueAccent]),
                        color: Color(0xff82b1ff),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Image.asset(
                              "assets/images/profile2.png",
                              height: 120,
                              width: 120,
                            ),
                          ),
                          Center(
                            child: Text(
                              "User Requests",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyQuote(
                                  uid: widget.uid,fullname: widget.fullname,address: widget.address,phone_no: widget.phone_no,place: widget.place,pincode: widget.pincode

                              )));
                    },
                    child: Container(
                      height: 250,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            colors: [Colors.green, Colors.blueAccent]),
                        color: Color(0xff82b1ff),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Image.asset(
                              "assets/images/note.png",
                              height: 120,
                              width: 120,
                            ),
                          ),
                          Center(
                            child: Text(
                              "View Quotes",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
