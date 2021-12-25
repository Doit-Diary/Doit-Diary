import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'writePost.dart';

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
        "/": (context) => WritePost(database),
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