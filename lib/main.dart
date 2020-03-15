import 'package:bytebankorigin/models/Contact.dart';
import 'package:bytebankorigin/models/transaction.dart';
import 'package:bytebankorigin/screens/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'http/webclient.dart';

void main() {
  runApp(BytebankApp());
  save(Transaction(200.0, Contact(0, 'Gui', 2000)))
      .then((transaction) => print("NOVO $transaction"));
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blueAccent[700],
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.blueAccent[700],
              textTheme: ButtonTextTheme.primary)),
      home: Dashboard(),
    );
  }
}
