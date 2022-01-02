import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:doit_diary/data/diary.dart';

class DiaryCardWidget extends StatelessWidget {
  DiaryCardWidget({
    Key? key,
    required this.diary,
    required this.index,
  }) : super(key: key);

  final Diary diary;
  final int index;

  @override
  Widget build(BuildContext context) {
    final color = Colors.amber.shade300;
    //final time = DateFormat.yMMMd().format(diary.createdTime); //시간기록
    final minHeight = getMinHeight(index);

    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   diary.date,
            //   style: TextStyle(color: Colors.grey.shade700),
            // ),
            SizedBox(height: 4),
            // Text(
            //   diary.title,
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}