class User {
  int? key;
  String? id;
  String? pw;
  String? nickname;

  User({this.key, this.id, this.pw, this.nickname});

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'id': id,
      'pw': pw,
      'nickname': nickname
    };
  }
}