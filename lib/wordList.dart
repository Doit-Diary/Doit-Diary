import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class wordList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _wordList();
}

class _wordList extends State<wordList>{ // 전체적으로 데이터 리스트를 받아오는 코드로 고쳐야함
  // 데이터 자료형에 isChecked도 필요함 디폴트 false
  int count1= 20;
  bool isChecked = false;
  bool longP = false;

  String? engWord ='English';
  String? korWord ='한국어' ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('단어장', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xffffef6f),
      ),
      body: Container(
        child: Center(
          child: ListView.builder(
              itemBuilder: (context, position) {
                return GestureDetector(
                  child: Card(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                                children: <Widget>[
                                  Text('${engWord}', style: TextStyle(fontSize: 20)),
                                  Text('${korWord}', style: TextStyle(fontSize: 20)),
                                ]),
                          ),
                          longP == true
                              ? Expanded(
                            child: Checkbox(
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                          ): Text(''),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceAround ,
                      )
                    //   child: Column(
                    //     children: <Widget>[
                    //       Text('${engWord}', style: TextStyle(fontSize: 25),),
                    //       Text('${korWord}', style: TextStyle(fontSize: 25),),
                    //   Checkbox(
                    //   value: isChecked,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       isChecked = value!;
                    //     });
                    //   },
                    // ),
                    //     ],
                    //   ),
                  ),
                  onLongPress: () {
                    setState(() {
                      longP = !longP;
                    });
                  },
                  // onTap: () {
                  //   AlertDialog dialog = AlertDialog(
                  //     content: Text('${engWord}의 뜻은 ${korWord} 입니다',
                  //       style: TextStyle(fontSize: 20),),
                  //   );
                  //   showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) => dialog
                  //   );
                  // },
                );
              },
              itemCount: count1
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('선택한 단어 삭제'),
                  content: Text('선택한 단어를 삭제할까요?'),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text('예')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text('아니요')),
                  ],
                );
              });
          if (result == true) {
            _removeWords();
          }
        },
        child: Icon(Icons.clear),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => setState(() {
      //     AlertDialog dialog = AlertDialog(
      //       content: Text('삭제하시겠습니까?'),
      //       actions: <Widget>[
      //         new TextButton(
      //           child: new Text("취소"),
      //           onPressed: () {
      //             Navigator.pop(context);
      //           },
      //         ),
      //         new TextButton(
      //           child: new Text("확인"),
      //           onPressed: () {
      //             Navigator.pop(context);
      //           },
      //         ),
      //       ],
      //     );
      //     showDialog(
      //         context: context, builder: (BuildContext context) => dialog);
      //   }),
      //   child: Text('삭제'),
      // ),
    );
  }

  // Future<List<Todo>> getClearList() async {  //db로 리스트 받아오기
  //   final Database database = await widget.database;
  //   List<Map<String, dynamic>> maps = await database
  //       .rawQuery('select title, content, id from todos where active=1');
  //
  //   return List.generate(maps.length, (i) {
  //     return Todo(
  //         title: maps[i]['title'].toString(),
  //         content: maps[i]['content'].toString(),
  //         id: maps[i]['id']);
  //   });
  // }
  //
  void _removeWords(){ // isChecked가 true인 데이터만 삭제해서 리스트 변경
    //   final Database database = await widget.database;
    //   database.rawDelete('delete from todos where active=1');
    //   setState(() {
    //     clearList = getClearList();
    //   });
    // }
  }


}
