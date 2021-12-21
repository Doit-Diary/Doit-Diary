import 'package:flutter/material.dart';

class SignPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignPage();
}

class _SignPage extends State<SignPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Do it! Diary 회원가입'),
      ),
      body: Container(
        child: ListView( // 위아래로 스크롤 될 수 있게
            children: <Widget> [
              SizedBox(
                child: Row(
                  children: <Widget> [
                    SizedBox(
                      width: 100, child:Text('약관 동의', style: TextStyle(fontSize: 20),)),
                    Checkbox(
                     activeColor: Colors.white,
                      checkColor: Colors.blue,
                      value: _isChecked,
                      onChanged: (value) {
                        setState(() {
                          _isChecked = value!;
                       });},),
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
                  width: 350, height: 45, child:Text('아이디', style: TextStyle(fontSize: 20),)),
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
                  width: 350, height: 45, child:Text('비밀번호 (영문, 숫자, 특수문자 포함)', style: TextStyle(fontSize: 20),)),
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
                  width: 350, height: 45, child:Text('닉네임', style: TextStyle(fontSize: 20),)),
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
                onPressed: () {
                  // 비밀번호 규정 검열식
                  //
                  //
                  //
                  //
                },
                child: Text('회원가입', style: TextStyle(color: Colors.black),),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange)),
              ),],
        ),),
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
