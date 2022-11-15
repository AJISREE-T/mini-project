import 'package:flutter/material.dart';
import 'package:trashcan/admin/adminhome.dart';
import 'package:trashcan/collectingagent/agenthome.dart';
import 'package:trashcan/commonscreens/appwelcome.dart';
import 'package:trashcan/commonscreens/registration.dart';
import 'package:trashcan/commonscreens/welcome.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:
          'TrashCan',

      debugShowCheckedModeBanner: false,
      home:AppLogin (),
    );
  }
}

