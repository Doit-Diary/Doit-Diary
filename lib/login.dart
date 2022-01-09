import 'dart:convert'; // json 및 utf8
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart'; //db
import 'package:flutter/src/widgets/form.dart';
import 'package:crypto/crypto.dart';
import 'dart:async';

import 'main.dart';
import 'data/user.dart';


class LoginPage extends StatefulWidget {
  final Future<Database> db;
  LoginPage(this.db);

  @override
  State<StatefulWidget> createState() => _LoginPage(db);
}

class _LoginPage extends State<LoginPage> with SingleTickerProviderStateMixin {
  final Future<Database> db;
  _LoginPage(this.db);

  TextEditingController? _idTextController;
  TextEditingController? _pwTextController;

  @override
  void initState() {
    super.initState();
    _idTextController = TextEditingController();
    _pwTextController = TextEditingController();
  }

  login() async {
    String uid = _idTextController!.text;
    String passwd = _pwTextController!.text;

    if (uid.isEmpty) {
      makeDialog("아이디를 입력해주세요");
    } else if (passwd.isEmpty) {
      makeDialog("비밀번호를 입력해주세요");
    } else {
      final Database database = await db;
      database.query('User');
      var bytes = utf8.encode(_pwTextController!.value.text); // 해쉬함수로 변환
      var cryptoPw = sha1.convert(bytes);
      var res = await database.rawQuery("SELECT * FROM User WHERE "
          "id = '$uid' AND "
          "pw = '$cryptoPw'");

      // 로그인 성공
      try {
        if (res[0] != null) {
          print((res[0]["key"]));
          setState(() {
            MyApp.user_key = int.parse(res[0]["key"].toString());
          });
          Navigator.pushReplacementNamed(context, '/home', arguments: [int.parse(res[0]["key"].toString())]);
          print(MyApp.user_key);
        }
      // 로그인 실패 - 수정
      } catch (Exception) { // Unhandled Exception: Null check operator used on a null value
        makeDialog("아이디 혹은 비밀번호가 맞지 않습니다");
      }

      // if (res[0] != null) {
      //   MyApp.user_key = res[0]["key"];
      //   Navigator.pushNamed(context, "/main"); // 지수님 화면으로 이동
      // } else {
      //
      // }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Do it! Diary'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _idTextController,
                  maxLines: 1,
                  decoration: InputDecoration(labelText: '아이디',
                      border: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _pwTextController,
                  obscureText: true, // 비밀번호 입력시 문자가 보이지 않게
                  maxLines: 1,
                  decoration: InputDecoration(labelText: '비밀번호',
                      border: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: login,
                child: Text('로그인',
                  style: TextStyle(color: Colors.black),),
                style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                    minimumSize: Size(350.0, 40.0)),),

              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/sign');
                  },
                  child: Text('회원가입',
                    style: TextStyle(color: Colors.black),),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xffffef6f),
                    minimumSize: Size(100.0, 40.0),
                  )),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),

    );
  }

  void makeDialog(String text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(text),
          );
        });
  }



}
