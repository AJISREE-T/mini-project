import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trashcan/admin/addproduct.dart';
import 'package:trashcan/admin/adminquote.dart';
import 'package:trashcan/admin/awareness.dart';
import 'package:trashcan/admin/awarenessview.dart';
import 'package:trashcan/admin/viewagents.dart';
import 'package:trashcan/admin/viewcomplaint.dart';
import 'package:trashcan/admin/viewproduct.dart';
import 'package:trashcan/admin/viewuserorder.dart';
import 'package:trashcan/admin/viewusers.dart';
import 'package:trashcan/common/colors.dart';
import 'package:trashcan/commonscreens/login.dart';

class AdminHome extends StatefulWidget {
  AdminHome({Key? key,}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
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
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage()));

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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder:(context)=>ViewUser())
                    );

                  },
                  child: Container(
                    height: 150,
                    width: 345,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(20, 30)),
                      color: Color(0xff01579b),
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [Colors.green, Colors.blueAccent]),
                    ),
                    child: Center(
                      child: Text(
                        "Users",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder:(context)=>ViewAgent())
                    );

                  },
                  child: Container(
                    height: 150,
                    width: 345,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(20, 30)),
                      color: Color(0xff01579b),
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [Colors.green, Colors.blueAccent]),
                    ),
                    child: Center(
                      child: Text(
                        "Agents",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder:(context)=>Awareness())
                    );

                  },
                  child: Container(
                    height: 150,
                    width: 345,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(20, 30)),
                      color: Color(0xff01579b),
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [Colors.green, Colors.blueAccent]),
                    ),
                    child: Center(
                      child: Text(
                        "Awareness Programs",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder:(context)=>ViewAware())
                    );

                  },
                  child: Container(
                    height: 150,
                    width: 345,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(20, 30)),
                      color: Color(0xff01579b),
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [Colors.green, Colors.blueAccent]),
                    ),
                    child: Center(
                      child: Text(
                        " View Awareness",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder:(context)=>AddProduct())
                    );

                  },
                  child: Container(
                    height: 150,
                    width: 345,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(20, 30)),
                      color: Color(0xff01579b),
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [Colors.green, Colors.blueAccent]),
                    ),
                    child: Center(
                      child: Text(
                        "Add Products",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder:(context)=>ViewProduct())
                    );

                  },
                  child: Container(
                    height: 150,
                    width: 345,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(20, 30)),
                      color: Color(0xff01579b),
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [Colors.green, Colors.blueAccent]),
                    ),
                    child: Center(
                      child: Text(
                        "View Products",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder:(context)=>AdminQuote())
                    );

                  },
                  child: Container(
                    height: 150,
                    width: 345,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(20, 30)),
                      color: Color(0xff01579b),
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [Colors.green, Colors.blueAccent]),
                    ),
                    child: Center(
                      child: Text(
                        "Quotes",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder:(context)=>UserOrder())
                    );

                  },
                  child: Container(
                    height: 150,
                    width: 345,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(20, 30)),
                      color: Color(0xff01579b),
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [Colors.green, Colors.blueAccent]),
                    ),
                    child: Center(
                      child: Text(
                        "Orders",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder:(context)=>ComPage())
                    );

                  },
                  child: Container(
                    height: 150,
                    width: 345,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(20, 30)),
                      color: Color(0xff01579b),
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [Colors.green, Colors.blueAccent]),
                    ),
                    child: Center(
                      child: Text(
                        "Complaints",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
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
      ),
    );
  }
}
