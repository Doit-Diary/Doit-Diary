import 'package:flutter/material.dart';
import 'login.dart';
import 'package:do_it_diary/signPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'do it 다이어리',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/sign' : (context) => SignPage(),
      },);}
}
