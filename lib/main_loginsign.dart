import 'package:flutter/material.dart';
import 'login.dart';
import 'signPage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'data/diary.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static Future<Database> database = initDatabase();
  static int user_key = 0;

  @override
  Widget build(BuildContext context) {
    // Future<Database> database = initDatabase();
    print("OK");

    return MaterialApp(
      title: 'do it 다이어리',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: LoginPage(database),
      // initialRoute: '/',
      routes: {
        //'/': (context) => LoginPage(database), // 데이터를 login페이지에 넘김
        '/sign' : (context) => SignPage(database), // 데이터를 sign페이지에 넘김
        '/main': (context) => HomeScreen(database)


      },); }

  static Future<Database> initDatabase() async { // path에서 db가 있는 위치와 이름을 결합시켜주는 코드
    String path = join(await getDatabasesPath(), 'do_it_diary.db');
    await deleteDatabase(path);
    return await openDatabase(path, version: 2, // db가 있으면 지우고 새로 만듦
        onCreate: (db, version) async {
          await db.execute(
              "CREATE TABLE User(key INTEGER PRIMARY KEY AUTOINCREMENT, "
                  "id TEXT NOT NULL UNIQUE, pw TEXT NOT NULL, nickname TEXT NOT NULL)"
          );
          await db.execute(
              "CREATE TABLE Diary(key INTEGER PRIMARY KEY AUTOINCREMENT, "
                  "title TEXT NOT NULL, content TEXT NOT NULL, date TEXT NOT NULL, user_key INTEGER NOT NULL, "
                  "CONSTRAINT key_fk FOREIGN KEY(user_key) REFERENCES User(key))"
          );
          await db.execute(
              "CREATE TABLE Voca(key INTEGER, "
                  "eng TEXT NOT NULL, kor TEXT NOT NULL, user_key INTEGER NOT NULL, "
                  "PRIMARY KEY(key, user_key), "
                  "CONSTRAINT key_fk FOREIGN KEY(user_key) REFERENCES User(key))"
          );
        }
    );
  }
}

class HomeScreen extends StatefulWidget {
  final Future<Database> db;
  HomeScreen(this.db);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Diary> diaries;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("나의 일기"),
        actions: [
          // onPressed: (){
          // DatabaseProvider.db.deleteNote(note.id);
          // Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
          // }
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              await Navigator.of(context).pushNamed('/writePost');
            },
          ),
        ],
      ),
      // body: FutureBuilder(
      //   future: getDairies()
      //   builder: (context, noteData){
      //     switch(noteData.connectionState){
      //       case ConnectionState.waiting:
      //         {
      //           return Center(child: CircularProgressIndicator());// 로딩중 표시
      //         }
      //       case ConnectionState.done:
      //         {
      //           if(noteData.data == Null){//Null값 체크
      //             return Center(
      //               child: Text("일기를 작성하지 않았습니다"),
      //             );
      //           }
      //           else{
      //             return Padding(
      //               padding: const EdgeInsets.all(8.0),//여백주기
      //               child: ListView.builder(
      //                 //itemCount : noteData.data.length,
      //                 itemBuilder: (context, index){//데이터 받아오기
      //                   String title = noteData.data[index]['title'];
      //                   String content = noteData.data[index]['content'];
      //                   String date = noteData.data[index]['date'];
      //                   String user_key = noteData.data[index]['user_key'];
      //                   return Card(child: ListTile(
      //                     onTap: (){
      //                       Diary note = noteData.data[index] as Diary;
      //                       Navigator.pushNamed(context,"/SpecificDiary", arguments: Diary(
      //                         title = title,
      //                         content = content,
      //                         date = date,
      //                         user_key = user_key,
      //                       )
      //                       );
      //                     },
      //                     title: Text('title'),
      //                     subtitle: Text('content'),
      //                   ),
      //                   );
      //                 },
      //               ),
      //             );
      //           }}
      //     }
      //
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.note_alt_rounded),
          onPressed: () async {
            await Navigator.of(context)
                .pushNamed('/vocaList');
          }),
    );
    // body: Center(
    //   child: Column,
    //);
  }

// Widget buildDiary() => StaggeredGridView.countBuilder(
//   padding: EdgeInsets.all(8),
//   itemCount: diaries.length,
//   staggeredTileBuilder: (index) => StaggeredTile.fit(2),
//   crossAxisCount: 4,
//   mainAxisSpacing: 4,
//   crossAxisSpacing: 4,
//   itemBuilder: (context, index) {
//     final diary = diaries[index];
//
//     return GestureDetector(
//         onTap: () async {
//           await Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => SpecificDiary(diarykey: diary.key!),
//           ));
//         },
//         child: DiaryCardWidget(diary: diary, index: index));
//   },
// );

}
