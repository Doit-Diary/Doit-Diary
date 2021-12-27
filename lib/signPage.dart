import 'dart:convert';
import 'package:flutter/material.dart';
import 'data/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:crypto/crypto.dart';

class SignPage extends StatefulWidget {
  final Future<Database> db;
  SignPage(this.db);

  @override
  State<StatefulWidget> createState() => _SignPage(db);
}

class _SignPage extends State<SignPage> {
  final Future<Database> db;

  _SignPage(this.db);

  TextEditingController? _idTextController;
  TextEditingController? _pwTextController;
  TextEditingController? _pwCheckTextController;
  TextEditingController? _nickNameTextController;
  var _isChecked = false;

  @override
  void initState() {
    super.initState();
    _idTextController = TextEditingController();
    _pwTextController = TextEditingController();
    _pwCheckTextController = TextEditingController();
    _nickNameTextController = TextEditingController();
  }

  final _formKey = new GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Do it! Diary 회원가입'),
      ),
      body: Container(
        child: ListView( // 위아래로 스크롤 될 수 있게
          children: <Widget>[
            SizedBox(
              child: Row(
                children: <Widget>[
                  SizedBox(
                      width: 100,
                      child: Text('약관 동의', style: TextStyle(fontSize: 20),)),
                  Checkbox(
                    activeColor: Colors.white,
                    checkColor: Colors.blue,
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
              height: 100,
            ),
            SizedBox(
              width: 400, height: 200,
              child: Text('(약관내용)'),),
            SizedBox(
              height: 20,),
            SizedBox(
                width: 350,
                height: 45,
                child: Text('아이디', style: TextStyle(fontSize: 20),)),
            SizedBox(
              width: 350,
              child: TextField(
                controller: _idTextController,
                maxLines: 1,
                decoration: InputDecoration(hintText: '아이디를 입력해주세요',
                    border: OutlineInputBorder()),),),
            SizedBox(
              height: 20,),
            SizedBox(
                width: 350,
                height: 45,
                child: Text(
                  '비밀번호 (영문, 숫자, 특수문자 포함)', style: TextStyle(fontSize: 20),)),
            SizedBox(
              width: 350,
              child: TextField(
                controller: _pwTextController,
                maxLines: 1,
                decoration: InputDecoration(hintText: '비밀번호를 입력해주세요',
                    border: OutlineInputBorder()),),),
            SizedBox(
              height: 20,),
            SizedBox(
                width: 350,
                height: 45,
                child: Text('비밀번호 확인', style: TextStyle(fontSize: 20),)),
            SizedBox(
              width: 350,
              child: TextField(
                controller: _pwCheckTextController,
                maxLines: 1,
                decoration: InputDecoration(hintText: '비밀번호를 입력해주세요',
                    border: OutlineInputBorder()),),),
            SizedBox(
              height: 20,),
            SizedBox(
                width: 350,
                height: 45,
                child: Text('닉네임', style: TextStyle(fontSize: 20),)),
            SizedBox(
              width: 350,
              child: TextField(
                controller: _nickNameTextController,
                maxLines: 1,
                decoration: InputDecoration(hintText: '닉네임을 입력해주세요',
                    border: OutlineInputBorder()),),),
            SizedBox(
              height: 30,),
            ElevatedButton(
              onPressed: () async {
                if (_pwTextController!.value.text !=
                    _pwCheckTextController!.value.text) {
                  makeDialog('비밀번호가 일치하지 않습니다');
                } else {
                  var bytes = utf8.encode(_pwTextController!.value.text); // 해쉬함수로 변환
                  var cryptoPw = sha1.convert(bytes);

                  User user = User(
                  id: _idTextController!.value.text,
                      pw: cryptoPw.toString(), // 해쉬함수로 암호화된 숫자로 db에 저장
                      nickname: _nickNameTextController!.value.text
                  );
                  _insertUser(user);
                  Navigator.pop(context);
                  _idTextController?.clear();
                  _selectAllUser();
                }
              },
              child: Text('회원가입', style: TextStyle(color: Colors.black),),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange)),
            ),
          ],
        ),),
    );
  }

  void _insertUser(User user) async {
    final Database database = await db;
    await database.insert('User', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
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

  void _selectAllUser() async {
    final Database database = await db;
    List<Map> result = await database.query('User');
    result.forEach((row) => print(row));
  }

}


// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:do_it_diary/user.dart';
// import 'package:sqflite/sqflite.dart';
//
// class SignPage extends StatefulWidget {
//   final Future<Database> db;
//   SignPage(this.db);
//
//   @override
//   State<StatefulWidget> createState() => _SignPage(db);
// }
//
// class _SignPage extends State<SignPage> {
//   final Future<Database> db;
//   _SignPage(this.db);
//
//   TextEditingController? _idTextController;
//   TextEditingController? _pwTextController;
//   TextEditingController? _pwCheckTextController;
//   TextEditingController? _nickNameTextController;
//   var _isChecked = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _idTextController = TextEditingController();
//     _pwTextController = TextEditingController();
//     _pwCheckTextController = TextEditingController();
//     _nickNameTextController = TextEditingController();
//   }
//
//   final _formKey = new GlobalKey<FormState>();
//
//   signUp() {
//     if(_formKey.currentState!.validate()) {
//       if(_pwTextController!.value.text != _pwCheckTextController!.value.text) {
//         makeDialog('비밀번호가 일치하지 않습니다');
//       } else {
//         _formKey.currentState!.save();
//         saveData();
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Do it! Diary 회원가입'),
//       ),
//       body: Container(
//         child: ListView( // 위아래로 스크롤 될 수 있게
//           children: <Widget> [
//             SizedBox(
//               child: Row(
//                 children: <Widget> [
//                   SizedBox(
//                       width: 100, child:Text('약관 동의', style: TextStyle(fontSize: 20),)),
//                   Checkbox(
//                     activeColor: Colors.white,
//                     checkColor: Colors.blue,
//                     value: _isChecked,
//                     onChanged: (value) {
//                       setState(() {
//                         _isChecked = value!;
//                       });},),
//                 ],
//                 mainAxisAlignment: MainAxisAlignment.start,
//               ),
//               height: 100,
//             ),
//                   SizedBox(
//                     width: 400, height: 200,
//                     child: Text('(약관내용)'),),
//                   SizedBox(
//                     height: 20,),
//                   SizedBox(
//                       width: 350, height: 45, child:Text('아이디', style: TextStyle(fontSize: 20),)),
//                   SizedBox(
//                     width: 350,
//                     child: TextField(
//                       controller: _idTextController,
//                       maxLines: 1,
//                       decoration: InputDecoration(hintText: '아이디를 입력해주세요',
//                           border: OutlineInputBorder()),),),
//                   SizedBox(
//                     height: 20,),
//                   SizedBox(
//                       width: 350, height: 45, child:Text('비밀번호 (영문, 숫자, 특수문자 포함)', style: TextStyle(fontSize: 20),)),
//                   SizedBox(
//                     width: 350,
//                     child: TextField(
//                       controller: _pwTextController,
//                       maxLines: 1,
//                       decoration: InputDecoration(hintText: '비밀번호를 입력해주세요',
//                           border: OutlineInputBorder()),),),
//                   SizedBox(
//                     height: 20,),
//                   SizedBox(
//                       width: 350, height: 45, child:Text('비밀번호 확인', style: TextStyle(fontSize: 20),)),
//                   SizedBox(
//                     width: 350,
//                     child: TextField(
//                       controller: _pwCheckTextController,
//                       maxLines: 1,
//                       decoration: InputDecoration(hintText: '비밀번호를 입력해주세요',
//                           border: OutlineInputBorder()),),),
//                   SizedBox(
//                     height: 20,),
//                   SizedBox(
//                       width: 350, height: 45, child:Text('닉네임', style: TextStyle(fontSize: 20),)),
//                   SizedBox(
//                     width: 350,
//                     child: TextField(
//                       controller: _nickNameTextController,
//                       maxLines: 1,
//                       decoration: InputDecoration(hintText: '닉네임을 입력해주세요',
//                           border: OutlineInputBorder()),),),
//                   SizedBox(
//                     height: 30,),
//                   ElevatedButton(
//                     onPressed: () {
//                       // 비밀번호 검열식
//                       if(_pwTextController!.value.text != _pwCheckTextController!.value.text) {
//                         makeDialog('비밀번호가 일치하지 않습니다');
//                       } else {
//                         // 회원가입 되는 코드
//
//     }
//                       }
//                     },
//                     child: Text('회원가입', style: TextStyle(color: Colors.black),),
//                             style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange)),
//                   ),],
//         ),),
//     );
//   }
//
//   Future<int> saveData(User user) async {
//     var dbClient = await db;
//     var res = await dbClient.insert(Table_User, user.toMap());
//     return res;
//   }
//
//
//   void makeDialog(String text) {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             content: Text(text),
//           );
//         });
//   }



