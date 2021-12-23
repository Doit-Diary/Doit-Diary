// import 'package:flutter/material.dart';
// import './writePost.dart';
// import './revisePost.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primaryColor: const Color(0xffffef6f)
//       ),
//       home: WritePost()
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
import 'dart:html';

import 'package:doitdairy_sue/specific_dairy.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'signPage.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'do it 다이어리',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => HomeScreen(),
        "/SpecificDairy": (context) => SpecificDairy(),
        '/sign' : (context) => SignPage(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget{
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
          //icon: Icon(Icons,delete),
          //onPressed: (){
          //DatabaseProvider.db.deleteNote(note.id);
          //Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
          //}
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
      //                   //String title = noteData.data[index]['title'];
      //                  // String content = noteData.data[index]['content'];
      //                   //String date = noteData.data[index]['date'];
      //                   //String userkey = noteData.data[index]['userkey'];
      //                   return Card(child: ListTile(
      //                     //onTap: (){
      //                       //NoteModel note = noteData.data[index] as NoteModel;
      //                       //Navigator.pushNamed(context,"/SpecificDariy", arguments: NoteModel(
      //                         //title = title,
      //                         //content = content,
      //                         //date = DateTime.parse(date),
      //                         //userkey = userkey,
      //                       //)
      //                       //);
      //                     //},
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
          Navigator.pushNamed(context, "/");//돌아갈때는 navigator.pop 쓰기
        },
        child: Icon(Icons.note_add),
      ),
    );
  }
}