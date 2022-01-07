import 'package:doit_diary/data/diary.dart';
import 'package:doit_diary/vocaList.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'addVoca.dart';
import 'writePost.dart';
import 'specificDiary.dart';
import 'signPage.dart';
//import 'Widget/DiaryForm.dart';
import 'Widget/DiaryCard.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static int user_key = 0;
  // 이 user_key가 0일 때는 정윤님 로그인 페이지로 보내시고
  // user_key가 0이 아닐 때는 그냥 메인 화면 보여주시면 될 거 같아요

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
        "/sign": (context) => SignPage(database),
        "/SpecificDiary": (context) => SpecificDiary(database),
        "/add": (context) => AddVoca(database),
        "/vocaList": (context) => VocaList(database),
        "/writePost": (context) => WritePost(database)
      },
    );
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'do_it_diary.db');
    await deleteDatabase(path);
    return await openDatabase(path, version: 2, onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE User(key INTEGER PRIMARY KEY AUTOINCREMENT, "
              "id TEXT NOT NULL UNIQUE, pw TEXT NOT NULL, nickname TEXT NOT NULL)");
      await db.execute(
          "CREATE TABLE Diary(key INTEGER PRIMARY KEY AUTOINCREMENT, "
              "title TEXT NOT NULL, content TEXT NOT NULL, date TEXT NOT NULL, user_key INTEGER NOT NULL, "
              "CONSTRAINT key_fk FOREIGN KEY(user_key) REFERENCES User(key))");
      await db.execute(
          "CREATE TABLE Voca(key INTEGER PRIMARY KEY AUTOINCREMENT, "
              "eng TEXT NOT NULL, kor TEXT NOT NULL, user_key INTEGER NOT NULL, "
              "CONSTRAINT key_fk FOREIGN KEY(user_key) REFERENCES User(key))");
    });
  }
}

class HomeScreen extends StatefulWidget {
  final Future<Database> db;
  HomeScreen(this.db);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Diary>>? diaries;

  @override
  void initState() {
    super.initState();
    diaries = refreshDiary();
  }

  Future<List<Diary>> refreshDiary() async {
    final Database database = await widget.db;
    final List<Map<String, dynamic>> maps = await database.query('Diary');

    return List.generate(maps.length, (i) {
      return Diary(
        key: maps[i]['key'],
        title: maps[i]['title'].toString(),
        content: maps[i]['content'].toString(),
        date: maps[i]['date'],
        user_key: maps[i]['user_key'],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("나의 일기"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final msg = await Navigator.of(context).pushNamed('/writePost');
              setState(() {
                diaries = refreshDiary();
              });
              if (msg != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(msg.toString()),
                      duration: Duration(seconds: 2),
                    )
                );
              }
            },
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder(
          builder: (context, noteData) {
            switch(noteData.connectionState){
              case ConnectionState.none:
                return CircularProgressIndicator();
              case ConnectionState.active:
                return CircularProgressIndicator();
              case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());// 로딩중 표시
              case ConnectionState.done:
                if ((noteData.data as List).isNotEmpty){//Null값 체크
                    return ListView.builder(
                      itemCount : (noteData.data as List<Diary>).length,
                      itemBuilder: (context, index){//데이터 받아오기
                        Diary diary = (noteData.data as List<Diary>)[index];
                        String title = diary.title!;
                        String content = diary.content!;
                        String date = diary.date!;
                        return Card(child: ListTile(
                          onTap: (){
                            Navigator.pushNamed(context,"/SpecificDiary", arguments: Diary(
                              title: diary.title!,
                              content: diary.content!,
                              date: diary.date!,
                              user_key: diary.user_key,
                            )
                            );
                          },
                          title: Text(title),
                          subtitle: Text(content),
                        ),
                        );
                      },
                    );
                  }
                  else {
                    return Text("일기를 작성하지 않았습니다");
                  }}
            },
          future: refreshDiary(),

        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.note_alt_rounded),
          onPressed: () async {
            await Navigator.of(context)
                .pushNamed('/vocaList');
          }),
    );
  }
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
// }