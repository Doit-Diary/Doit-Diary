import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'data/diary.dart';
import 'package:sqflite/sqflite.dart';


class SpecificDiary extends StatefulWidget{
  final Future<Database> db;
  SpecificDiary(this.db);

  @override
  State<StatefulWidget> createState() => _SpecificDiaryState();
}

class _SpecificDiaryState extends State<SpecificDiary>{
  bool isLoading = false;
  String? diary_title;
  String? diary_content;

  @override
  void initState(){
    super.initState();
  }
  Future refreshDiary() async{
    setState(() => isLoading = true);
    //this.diary = await Diary.instance.readDiary(widget.diarykey);
  }
  Widget build(BuildContext context){
    final arguments = ModalRoute.of(context)?.settings.arguments as Diary;

    diary_title = arguments.title!;
    diary_content = arguments.content!;

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
                  onTap: () async {
                    await Navigator.pushNamed(context,"/revisePost", arguments: Diary(
                      key: arguments.key,
                      title: arguments.title!,
                      content: arguments.content!,
                      date: arguments.date!,
                      user_key: arguments.user_key,
                    )).then((val) {
                      if (val != null) {
                        // setState(() {
                        //   diary_title = ((new_diary as Diary).title!);
                        //   diary_content = ((new_diary as Diary).content!);
                        // });
                        Navigator.pop(context, val);
                      }
                    });
                  }
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
          Text(
            diary_title!,
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          // Text(
          //   /* 날짜 이거 어떻게 바꾸는지 모르겠네요 */
          //   /* 바꿔주세여 */
          //   DateFormat.yMMMd().format(diary.date!),
          //   style: TextStyle(color: Colors.white38),
          // ),
          SizedBox(height: 8),
          Text(
            diary_content!,
            style: TextStyle(color: Colors.black, fontSize: 18),
          )
        ],
      ),
    ),
  );
  }
}