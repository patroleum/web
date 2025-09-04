// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    User user;
    String token;
    String refreshToken;
    String tokenDss;
    String signature;
    String userId;

    UserModel({
      required this.user,
      required this.token,
      required this.refreshToken,
      required this.tokenDss,
      required this.signature,
      required this.userId,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: User.fromJson(json['user']),
        token: json['token'],
        refreshToken: json['refreshToken'],
        tokenDss: json['tokenDSS'],
        signature: json['signature'],
        userId: json['userId'],
    );

    Map<String, dynamic> toJson() => {
        'user': user.toJson(),
        'token': token,
        'refreshToken': refreshToken,
        'tokenDSS': tokenDss,
        'signature': signature,
        'userId': userId,
    };
}

class User {
  int idUser;
  String name;
  String lastname;
  String email;

  User({
      required this.idUser,
      required this.name,
      required this.lastname,
      required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      idUser: json['id_user'],
      name: json['name'],
      lastname: json['lastname'],
      email: json['email'],
  );

  Map<String, dynamic> toJson() => {
      'id_user': idUser,
      'name': name,
      'lastname': lastname,
      'email': email,
  };
}
