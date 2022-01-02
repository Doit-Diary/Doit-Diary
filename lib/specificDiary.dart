import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doit_diary/data/diary.dart';

class SpecificDiary extends StatefulWidget{
  final int diarykey;
  const SpecificDiary({
    Key? key,
    required this.diarykey,
}):super(key: key);
  @override
  _SpecificDiaryState createState() => _SpecificDiaryState();
}

class _SpecificDiaryState extends State<SpecificDiary>{
  late Diary diary;
  bool isLoading = false;
  @override
  void initState(){
    super.initState();
  }
  Future refreshDiary()async{
    setState(() => isLoading = true);
    //this.diary = await Diary.instance.readDiary(widget.diarykey);
  }
  Widget build(BuildContext context){


  return Scaffold(
    appBar: AppBar(
      title: Text("나의 일기"),//앱바
      actions: [
        PopupMenuButton(itemBuilder: (context){
        return <PopupMenuEntry<String>>[
          PopupMenuItem(
              value: 'ReviseButton',
              child: ListTile(
                title: Text('수정하기'),
              )
          ),
          PopupMenuItem(
              value: 'DeleteButton',
              child: ListTile(
                title: Text('삭제하기'),
              )
          )
        ];
      }),],
    ),
    body:  isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
      padding: EdgeInsets.all(12),
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 8),
        children: [
          // Text(
          //   diary.title,
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 22,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          SizedBox(height: 8),
          // Text(
          //   DateFormat.yMMMd().format(diary.createdTime),
          //   style: TextStyle(color: Colors.white38),
          // ),
          SizedBox(height: 8),
          // Text(
          //   diary.content,
          //   style: TextStyle(color: Colors.white70, fontSize: 18),
          // )
        ],
      ),
    ),
  );
  }
}