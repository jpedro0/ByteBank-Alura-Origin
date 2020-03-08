import 'package:bytebankorigin/screens/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(bytebankApp());
}

class bytebankApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary
        )
      ),
      home: Dashboard(),
    );
  }
}
