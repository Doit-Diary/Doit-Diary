import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'data/diary.dart';
import 'package:sqflite/sqflite.dart';

class RevisePost extends StatelessWidget {
  final Future<Database> db;
  RevisePost(this.db);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Diary;

    final titleController = TextEditingController();
    final contentController = TextEditingController();
    titleController.text = arguments.title!;
    contentController.text = arguments.content!;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('일기 수정', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.amber,
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.Center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 25),
                        child: TextField(
                            controller: titleController,
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            decoration: InputDecoration(
                                labelText: 'title',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 3, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 3, color: Colors.amber),
                                    borderRadius: BorderRadius.circular(15)
                                )
                            )
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(bottom: 25),
                          child: new Container(
                              height: 400,
                              child: new SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  reverse: true,
                                  child: SizedBox(
                                      height: 400,
                                      child: TextField(
                                          controller: contentController,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 20,
                                          decoration: InputDecoration(
                                              labelText: 'content',
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(width: 3, color: Colors.grey),
                                                  borderRadius: BorderRadius.circular(15)
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(width: 3, color: Colors.amber),
                                                  borderRadius: BorderRadius.circular(15)
                                              )
                                          )
                                      )
                                  )
                              )
                          )
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            OutlinedButton(
                              // 임시
                                child: Text('수정 취소', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            content: Text("내용을 수정 중에 있습니다.\n"
                                                "수정을 취소하시겠습니까?"),
                                            actions: <Widget>[
                                              TextButton(
                                                  child: new Text("취소", style: TextStyle(color: Colors.red)),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  }
                                              ),
                                              TextButton(
                                                  child: new Text("계속 수정", style: TextStyle(color: Colors.blue)),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  }
                                              )
                                            ]
                                        );
                                      }
                                  );
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                                    padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                                    textStyle: MaterialStateProperty.all(TextStyle(
                                        fontSize: 20
                                    ))
                                )
                            ),
                            OutlinedButton(
                              // 임시
                                child: Text('수정', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      if (titleController.text.trim() == '') {
                                        return AlertDialog(
                                            content: Text("제목을 입력해주세요."),
                                            actions: <Widget>[
                                              TextButton(
                                                  child: new Text("확인"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  }
                                              )
                                            ]
                                        );
                                      } else if (contentController.text.trim() == '') {
                                        return AlertDialog(
                                            content: Text("내용을 입력해주세요."),
                                            actions: <Widget>[
                                              TextButton(
                                                  child: new Text("확인"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  }
                                              )
                                            ]
                                        );
                                      } else {
                                        return AlertDialog(
                                            content: Text("이대로 저장하시겠습니까?"),
                                            actions: <Widget>[
                                              TextButton(
                                                  child: new Text("계속 작성",
                                                      style: TextStyle(color: Colors.red)),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  }
                                              ),
                                              TextButton(
                                                  child: new Text("저장",
                                                      style: TextStyle(color: Colors.blue)),
                                                  onPressed: () {
                                                    Diary diary = Diary(
                                                      key: arguments.key,
                                                      title: (titleController.value.text.trim().isEmpty ? 'temp' : titleController.value.text.trim()),
                                                      content: contentController.value.text.trim(),
                                                      date: arguments.date,
                                                      user_key: arguments.user_key, // 수정 필요
                                                    );
                                                    _updateDiary(diary);
                                                    _selectAllDiary();
                                                    /* 여기다 */
                                                    Navigator.of(context).popUntil((route) => route.isFirst);
                                                  }
                                              )
                                            ]
                                        );
                                      }
                                    },
                                  );
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.amber),
                                    padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                                    textStyle: MaterialStateProperty.all(TextStyle(
                                        fontSize: 20
                                    ))
                                )
                            )
                          ]
                      )
                    ]
                )
            )
        )
    );
  }

  void _updateDiary(Diary diary) async {
    final Database database = await db;
    await database.update('Diary', diary.toMap(),
        where: 'key = ?', whereArgs: [diary.key],
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  void _selectAllDiary() async {
    final Database database = await db;
    List<Map> result = await database.query('Diary');
    result.forEach((row) => print(row));
  }
}