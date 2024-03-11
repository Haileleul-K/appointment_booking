// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));



class User {
    ClientUserLink clientUserLink;

    User({
        required this.clientUserLink,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        clientUserLink: ClientUserLink.fromJson(json["client_user_link"]),
    );

}

class ClientUserLink {
    int userId;
    DateTime? createdAt;
    DateTime? updatedAt;
    int id;
    String role;
    UserClass user;

    ClientUserLink({
        required this.userId,
         this.createdAt,
         this.updatedAt,
        required this.id,
        required this.role,
        required this.user,
    });

    factory ClientUserLink.fromJson(Map<String, dynamic> json) => ClientUserLink(
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        id: json["id"],
        role: json["role"],
        user: UserClass.fromJson(json["user"]),
    );
}

class UserClass {
    int id;
    String email;
    String name;
    DateTime? createdAt;
    DateTime? updatedAt;

    UserClass({
        required this.id,
        required this.email,
        required this.name,
        required this.createdAt,
        required this.updatedAt,
    });

    factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );
}
