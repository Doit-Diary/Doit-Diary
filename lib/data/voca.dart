class Voca {
  int? key;
  String? eng;
  String? kor;
  int? user_key;

  Voca({this.key, this.eng, this.kor, this.user_key});

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'eng': eng,
      'kor': kor,
      'user_key': user_key
    };
  }
}