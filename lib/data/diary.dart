class Diary {
  int? key;
  String? title;
  String? content;
  // SQLite는 DateTime을 지원하지 않습니다. String으로 대체합니다
  String? date;
  int? user_key;

  Diary({this.key, this.title, this.content, this.date, this.user_key});

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'title': title,
      'content': content,
      'date': date,
      'user_key': user_key
    };
  }

}