import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

import 'data/voca.dart';

class VocaList extends StatefulWidget{
  final Future<Database> db;
  VocaList(this.db);

  @override
  State<StatefulWidget> createState() => _VocaList();
}

class _VocaList extends State<VocaList>{ // 전체적으로 데이터 리스트를 받아오는 코드로 고쳐야함
  // 데이터 자료형에 isChecked도 필요함 디폴트 false
  Future<List<Voca>>? vocaList;

  @override
  void initState() {
    super.initState();
    vocaList = getVoca();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('단어장', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xffffef6f),
      ),

      body: Container(
        child: FutureBuilder(
          builder: (context,snapshot){
            switch (snapshot.connectionState){
              case ConnectionState.none:
                return CircularProgressIndicator();
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.active:
                return CircularProgressIndicator();
              case ConnectionState.done:
                if(snapshot.hasData){
                  return ListView.builder(
                    itemBuilder: (context,index){
                      Voca voca = (snapshot.data as List<Voca>)[index];
                      return ListTile(
                        title:Text(
                          voca.eng!,
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                voca.kor!,
                                style: TextStyle(fontSize: 20),),
                              Container(
                                height: 1,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                        onLongPress: () async {
                          Voca result = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('${voca.eng} 삭제'),
                                  content:
                                  Text('${voca.kor}를 삭제하시겠습니까?'),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          voca.isChecked=1;
                                          Navigator.of(context).pop(voca);
                                        },
                                        child: Text('예')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('아니요')),
                                  ],
                                );
                              });
                          _deleteVoca(result);
                        },
                      );
                    },
                    itemCount: (snapshot.data as List<Voca>).length,
                  );
                }else{
                  return Text('NO data');
                }
            }
            return CircularProgressIndicator();
          },
          future: vocaList,
        ),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          final voca = await Navigator.of(context).pushNamed('/add');
          if(voca != null){
            _insertVoca(voca as Voca);
          }
        },

        child: Icon(Icons.add),
      ),
    );
  }

  void _deleteVoca(Voca voca) async {
    final Database database = await widget.db;
    await database.delete('Voca', where: 'isChecked=?', whereArgs: [voca.isChecked]);
    setState(() {
      vocaList = getVoca();
    });
  }
  void _insertVoca(Voca voca) async{
    final Database database = await widget.db;
    await database.insert('Voca', voca.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Voca>> getVoca() async {
    final Database database = await widget.db;
    final List<Map<String, dynamic>> maps = await database.query('Voca');

    return List.generate(maps.length, (i) {
      return Voca(
          key: maps[i]['key'],
          eng: maps[i]['eng'].toString(),
          kor: maps[i]['kor'].toString(),
          user_key: maps[i]['user_key'],
          isChecked: maps[i]['isChecked'],
      );
    });
  }
}
