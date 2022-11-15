import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:trashcan/commonscreens/login.dart';
import 'package:trashcan/commonscreens/registration.dart';
import 'package:trashcan/common/colors.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Lottie.asset('assets/lotties/logo.json',height: 150,width: 200)
                ),
                Text(
                  "TrashCan",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,

                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Clean spaces,Happy Faces",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,

                  ),
                ),
                SizedBox(height: 50),
                Container(
                    width: 280,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xff1565c0),
                          side: BorderSide(
                            color: Color(0xff64dd17),
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                    )),
                SizedBox(height: 20),
                Container(
                    width: 280,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xff1565c0),
                          side: BorderSide(
                            color: Color(0xff64dd17),
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                    )),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
