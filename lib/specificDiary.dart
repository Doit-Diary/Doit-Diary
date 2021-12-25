import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpecificDairy extends StatelessWidget{
  const SpecificDairy({Key ?key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    //final Notemodel note = ModalRoute().of(context).settings.arguments as NoteModel//모델 받아오기
  return Scaffold(
    appBar: AppBar(
      title: Text("나의 일기"),//앱바
    ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),//여백
      child: Column(
        children: [
          Text(
          'title'
            //note.title,
            //style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),//폰트 설정
          )
          ,SizedBox(height: 16.0,),
          Text(
            'content'
            //note.content,
            ,style: TextStyle(fontSize:18.0 ),
          )
        ],
      )
    ),
  );
  }
}