import 'package:doit_diary/wordList.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'specificDiary.dart';
import 'signPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();
    print("OK");

    return MaterialApp(
      title: 'do it 다이어리',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => HomeScreen(database),
        "/SpecificDiary": (context) => SpecificDiary(),
        "/sign" : (context) => SignPage(database),
        "/wordList": (context) => wordList()
      },
    );
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'do_it_diary.db');
    await deleteDatabase(path);
    return await openDatabase(path, version: 2,
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

class HomeScreen extends StatefulWidget{
  final Future<Database> db;
  HomeScreen(this.db);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  getNotes() async{
    //final notes = await DatabaseProvider.db.getNotes();// db 폴더 밑에 dbprovider.dart 넣어서 db provider 함수 넣기
    //return notes
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("나의 일기"),
        actions: [

          // onPressed: (){
          // DatabaseProvider.db.deleteNote(note.id);
          // Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
          // }
        ],
      ),
      // body: FutureBuilder(
      //   future: getNotes(),
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
      //                 padding: const EdgeInsets.all(8.0),//여백주기
      //               child: ListView.builder(
      //                 //itemCount : noteData.data.length,
      //                 itemBuilder: (context, index){//데이터 받아오기
      //                   // String title = noteData.data[index]['title'];
      //                   // String content = noteData.data[index]['content'];
      //                   // String date = noteData.data[index]['date'];
      //                   // String user_key = noteData.data[index]['user_key'];
      //                   return Card(child: ListTile(
      //                     // onTap: (){
      //                     //   NoteModel note = noteData.data[index] as NoteModel;
      //                     //   Navigator.pushNamed(context,"/SpecificDariy", arguments: NoteModel(
      //                     //     title = title,
      //                     //     content = content,
      //                     //     date = DateTime.parse(date),
      //                     //     user_key = user_key,
      //                     //   )
      //                     //   );
      //                     // },
      //                     title: Text('title'),
      //                     subtitle: Text('content'),
      //                   ),
      //                   );
      //                 },
      //               ),
      //             );
      //           }}
      //         }
      //
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, "/wordList");//돌아갈때는 navigator.pop 쓰기
        },
        tooltip: 'WordList',
        child: Icon(Icons.add),
      ),
    );
  }
}