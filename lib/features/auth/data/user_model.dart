// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));


class User {
    ClientUserLink? clientUserLink;

    User({
        this.clientUserLink,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        clientUserLink: json["client_user_link"] == null ? null : ClientUserLink.fromJson(json["client_user_link"]),
    );


}

class ClientUserLink {
    int? userId;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? id;
    String? role;
    UserClass? user;

    ClientUserLink({
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.id,
        this.role,
        this.user,
    });

    factory ClientUserLink.fromJson(Map<String, dynamic> json) => ClientUserLink(
        userId: json["user_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        id: json["id"],
        role: json["role"],
        user: json["user"] == null ? null : UserClass.fromJson(json["user"]),
    );

    }

class UserClass {
    int? id;
    String? email;
    String? name;
    DateTime? createdAt;
    DateTime? updatedAt;

    UserClass({
        this.id,
        this.email,
        this.name,
        this.createdAt,
        this.updatedAt,
    });

    factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );
}
