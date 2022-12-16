import 'package:flutter/material.dart';

void main() => runApp(IAmPoorApp());

class IAmPoorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.brown,
        appBar: AppBar(
          title: Text('I Am Poor'),
          backgroundColor: Colors.brown[900],
        ),
        body: Center(
          child: Center(
            child: Image(
              image: AssetImage(
                  'images/money.png'
              ),
            ),
          ),
        ),
      ),
    );
  }
}