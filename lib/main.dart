import 'package:flutter/material.dart';
import 'package:whatspp_numberer/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      title: "WhatsOpen",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MainPage()
    );
  }
}