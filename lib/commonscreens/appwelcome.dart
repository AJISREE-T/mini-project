import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:trashcan/collectingagent/agenthome.dart';
import 'package:trashcan/commonscreens/login.dart';
import 'package:trashcan/commonscreens/welcome.dart';
import 'package:trashcan/common/colors.dart';
import 'package:trashcan/user/userhome.dart';


class AppLogin extends StatefulWidget {
  const AppLogin({Key? key}) : super(key: key);

  @override
  _AppLoginState createState() => _AppLoginState();
}

class _AppLoginState extends State<AppLogin> {
  initState(){
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if(event==null){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => WelcomePage()));
      }
      else
        {
          FirebaseFirestore.instance
              .collection('Login')
              .doc(event.uid)
              .get()
              .then((value) {
            if (value.data()!['type'] ==
                'Collecting Agent' &&
                value.data()!['status'] == 1) {
              FirebaseFirestore.instance
                  .collection(
                  'Collecting Agent')
                  .doc(value.data()!['uid'])
                  .get()
                  .then((value) {
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
          });
        }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/lotties/logo.json')
          ],
        ),
      )),
    );
  }
}
