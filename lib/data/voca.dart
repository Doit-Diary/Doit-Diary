class Voca {
  int? key;
  String? eng;
  String? kor;
  int? user_key;
  int? isChecked;

  Voca({this.key,this.eng, this.kor, this.user_key, this.isChecked});

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'eng': eng,
      'kor': kor,
      'user_key': user_key,
      'isChecked': isChecked
    };
  }
}