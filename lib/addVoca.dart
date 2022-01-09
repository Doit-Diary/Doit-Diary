import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'main.dart';
import 'data/voca.dart';

class AddVoca extends StatefulWidget {
  final Future<Database> db;

  AddVoca(this.db);

  @override
  State<StatefulWidget> createState() => _AddVoca();
}

class _AddVoca extends State<AddVoca> {

  TextEditingController? engController;
  TextEditingController? korController;
  static int keyNum=1;

  @override
  void initState() {
    super.initState();
    engController = new TextEditingController();
    korController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VOCA 추가', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: engController,
                  decoration: InputDecoration(labelText: '영어 단어'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: korController,
                  decoration: InputDecoration(labelText: '뜻'),
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  Voca voca = Voca(
                      eng: engController!.value.text,
                      kor: korController!.value.text,
                      user_key: MyApp.user_key
                  );
                  Navigator.of(context).pop(voca);
                },
                child: Text('추가'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
