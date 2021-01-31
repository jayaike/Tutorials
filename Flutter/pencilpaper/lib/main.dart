import 'package:flutter/material.dart';
import 'package:pencilpaper/paper_field.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 50.0),
          child: PaperField(
            initialText: "Hey, I am a paper field"
          )
        ),
      )
    );
  }
}

