import 'package:flutter/material.dart';

class RevisePost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('일기 수정', style: TextStyle(color: Colors.black)),
          backgroundColor: const Color(0xffffef6f),
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
                                labelText: '제목',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 3, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 3, color: const Color(0xffffef6f)),
                                    borderRadius: BorderRadius.circular(15)
                                )
                            )
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(bottom: 25),
                          child: TextField(
                              controller: contentController,
                              keyboardType: TextInputType.text,
                              maxLines: 20,
                              decoration: InputDecoration(
                                  labelText: '내용',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 3, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 3, color: const Color(0xffffef6f)),
                                      borderRadius: BorderRadius.circular(15)
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
                                                  Navigator.pop(context);
                                                }
                                            )
                                          ]
                                      );
                                    },
                                  );
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(const Color(0xffffef6f)),
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
}