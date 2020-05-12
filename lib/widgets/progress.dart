import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  final String message;
  Progress({this.message = 'Loading'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.only(top:16.0),
            child: Text(message, style: TextStyle(fontSize: 16.0)),
          ),
        ],
      ),
    );
  }
}
