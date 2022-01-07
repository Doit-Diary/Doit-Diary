import 'dart:convert'; // json 및 utf8
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart'; //db
import 'package:shared_preferences/shared_preferences.dart'; // 자동로그인
import 'package:flutter/src/widgets/form.dart';
import 'package:crypto/crypto.dart';
import 'dart:async';

import 'main_loginsign.dart';
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

  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = new GlobalKey<FormState>();

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
      List<Map> res = await database.rawQuery("SELECT * FROM User WHERE "
          "id = '$uid' AND "
          "pw = '$cryptoPw'");

      try {
        if (res[0] != null) {
          MyApp.user_key = res[0]["key"];
          Navigator.pushNamed(context, "/main"); // 지수님 화면으로 이동
        }
      } catch (Exception) {
        // Unhandled Exception: Null check operator used on a null value
        makeDialog("아이디 혹은 비밀번호가 맞지 않습니다");
      }

      // if (res[0] != null) {
      //   MyApp.user_key = res[0]["key"];
      //   Navigator.pushNamed(context, "/main"); // 지수님 화면으로 이동
      // } else {
      //
      // }


      // db.getLoginUser(uid, passwd).then((userData) {
      //   if (userData != null) {
      //     setSP(userData).whenComplete(() {
      //       //Navigator.pushAndRemoveUntil( // 메인페이지로 이동
      //        //   context,
      //          // MaterialPageRoute(builder: (_) => ),
      //            //   (Route<dynamic> route) => false);
      //     });
      //   } else {
      //     makeDialog("Error: 사용자가 존재하지 않습니다");
      //   }
      // }).catchError((error) {
      //   print(error);
      //   makeDialog("Error: 로그인 실패");
      // });
    }
  }


  Future setSP(User user) async {
    final SharedPreferences sp = await _pref;

    sp.setString("user_id", user.id!);
    sp.setString("password", user.pw!);
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
                    primary: Colors.yellow,
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
