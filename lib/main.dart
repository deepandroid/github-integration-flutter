import 'package:flutter/material.dart';
import 'package:flutter_app/ListViewJsonapi.dart';
import 'package:github/github.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter GitHub Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListViewJsonApi(),
    );
  }
}

