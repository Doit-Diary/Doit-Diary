import 'package:flutter/material.dart';
import 'login.dart';
import 'package:do_it_diary/signPage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();
    print("OK");

    return MaterialApp(
      title: 'do it 다이어리',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(database), // 데이터를 login페이지에 넘김
        '/sign' : (context) => SignPage(database), // 데이터를 sign페이지에 넘김
      },);}

  Future<Database> initDatabase() async { // path에서 db가 있는 위치와 이름을 결합시켜주는 코드
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
