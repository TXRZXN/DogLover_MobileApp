import 'dart:convert';

class UserModel {
  final String username;
  final String email;
  final String userid;
  UserModel({
    required this.username,
    required this.email,
    required this.userid,
  });

  UserModel copyWith({
    String? username,
    String? email,
    String? userid,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      userid: userid ?? this.userid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'userid': userid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'],
      email: map['email'],
      userid: map['userid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(username: $username, email: $email, userid: $userid)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.username == username &&
      other.email == email &&
      other.userid == userid;
  }

  @override
  int get hashCode => username.hashCode ^ email.hashCode ^ userid.hashCode;
}
