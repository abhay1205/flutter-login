import 'package:firebaselogin/SignIn.dart';
import 'package:firebaselogin/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'HomePage.dart';

void main() => runApp(MyApp());

// First put json file in android and json
// use gradle in android plugin
// yaml for firebase

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Loogin',
      theme: ThemeData(),
      home: HomePage(),
      routes: {
        '/home': (BuildContext context)=> HomePage(),
        '/signin': (BuildContext context)=> SignIn(),
        '/signup': (BuildContext context)=> SignUp(),
      },
    );
  }
}