import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/common/colors.dart';
import 'package:trashcan/user/buyproduct.dart';
import 'package:trashcan/user/complaint.dart';
import 'package:trashcan/user/submitwaste.dart';
import 'package:trashcan/user/userawareness.dart';
import 'package:trashcan/user/userprofile.dart';
import 'package:trashcan/user/viewactions.dart';
import 'package:trashcan/user/vieworders.dart';
import 'package:trashcan/user/viewquote.dart';
import 'package:trashcan/user/viewwaste.dart';
import 'package:trashcan/commonscreens/login.dart';


class UserHome extends StatefulWidget {
  var uid;
  var fullname;
  var address;
  var place;
  var pincode;
  var phone_no;
  UserHome({Key? key,this.uid,this.fullname,this.address,this.place,this.pincode,this.phone_no}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
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
          child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       Container(
                //         height: 250,
                //         width: 335,
                //         child: Image.asset(
                //           "assets/images/ewaste1-removebg-preview.png",
                //           height: 150,
                //           width: 150,
                //         ),
                //         decoration: BoxDecoration(
                //           borderRadius:
                //               BorderRadius.all(Radius.elliptical(20, 30)),
                //           color: Color(0xff00b8d4),
                //         ),
                //       ),
                //       SizedBox(
                //         width: 5,
                //       ),
                //       Container(
                //         height: 250,
                //         width: 335,
                //         child: Image.asset(
                //           "assets/images/ewaste2-removebg-preview.png",
                //           height: 150,
                //           width: 150,
                //         ),
                //         decoration: BoxDecoration(
                //           borderRadius:
                //               BorderRadius.all(Radius.elliptical(20, 30)),
                //           color: Color(0xff00b8d4),
                //         ),
                //       ),
                //       SizedBox(
                //         width: 5,
                //       ),
                //       Container(
                //         height: 250,
                //         width: 335,
                //         child: Image.asset(
                //           "assets/images/myquote.png",
                //           height: 150,
                //           width: 150,
                //         ),
                //         decoration: BoxDecoration(
                //           borderRadius:
                //               BorderRadius.all(Radius.elliptical(20, 30)),
                //           color: Color(0xff00b8d4),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                Text(
                  "Welcome! ${widget.fullname}",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,

                  ),
                ),
                SizedBox(height: 50),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SubmitWaste(uid: widget.uid,fullname: widget.fullname,address: widget.address,phone_no: widget.phone_no,place: widget.place,pincode: widget.pincode)));
                        },
                        child: Container(
                          height: 180,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            color: Color(0xff558b2f),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Image.asset(
                                  "assets/images/ewaste3.png",
                                  height: 120,
                                  width: 120,
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Submit Waste",
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
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewWaste(uid: widget.uid,fullname: widget.fullname,address: widget.address,phone_no: widget.phone_no,place: widget.place,pincode: widget.pincode)));
                        },
                        child: Container(
                          height: 180,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            color: Color(0xff558b2f),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Image.asset(
                                  "assets/images/dust.png",
                                  height: 120,
                                  width: 120,
                                ),
                              ),
                              Center(
                                child: Text(
                                  "View Waste",
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
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
                          height: 180,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            color: Color(0xff82b1ff),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
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
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewQuote(uid: widget.uid,fullname: widget.fullname,address: widget.address,phone_no: widget.phone_no,place: widget.place,pincode: widget.pincode)));
                        },
                        child: Container(
                          height: 180,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            color: Color(0xff82b1ff),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Image.asset(
                                  "assets/images/note.png",
                                  height: 120,
                                  width: 120,
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Quotes",
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BuyProduct(uid: widget.uid,fullname: widget.fullname,address: widget.address,phone_no: widget.phone_no,place: widget.place,pincode: widget.pincode)));
                        },
                        child: Container(
                          height: 180,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            color: Color(0xff5c6bc0),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Image.asset(
                                  "assets/images/eproduct.png",
                                  height: 120,
                                  width: 120,
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Buy Products",
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
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewOrder(uid: widget.uid,fullname: widget.fullname,address: widget.address,phone_no: widget.phone_no,place: widget.place,pincode: widget.pincode)));

                        },
                        child: Container(
                          height: 180,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            color: Color(0xff01579b),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Image.asset(
                                  "assets/images/eproduct.png",
                                  height: 120,
                                  width: 120,
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Orders",
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ComplaintPage(uid: widget.uid,fullname: widget.fullname,address: widget.address,phone_no: widget.phone_no,place: widget.place,pincode: widget.pincode)));

                        },
                        child: Container(
                          height: 180,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            color: Color(0xffffcdd2),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Image.asset(
                                  "assets/images/complaint.png",
                                  height: 120,
                                  width: 120,
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Complaints",
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
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewAction(uid: widget.uid,fullname: widget.fullname,address: widget.address,phone_no: widget.phone_no,place: widget.place,pincode: widget.pincode)));

                        },
                        child: Container(
                          height: 180,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            color: Color(0xffffcdd2),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Image.asset(
                                  "assets/images/complaint.png",
                                  height: 120,
                                  width: 120,
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Actions",
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserAware(uid: widget.uid,fullname: widget.fullname,address: widget.address,phone_no: widget.phone_no,place: widget.place,pincode: widget.pincode)));

                        },
                        child: Container(
                          height: 180,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            color: Color(0xff26a69a),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Image.asset(
                                  "assets/images/awareness.png",
                                  height: 120,
                                  width: 120,
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Awareness",
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
