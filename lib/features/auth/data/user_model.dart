// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String? token;
    User? user;

    UserModel({
        this.token,
        this.user,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json["token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "user": user?.toJson(),
    };
}

class User {
    String? id;
    String? firstName;
    String? lastName;
    String? phoneNumber;
    String? email;
    String? role;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    List<dynamic>? trips;
    List<dynamic>? vehicles;
    List<dynamic>? tickets;
    List<dynamic>? assignedRoutes;

    User({
        this.id,
        this.firstName,
        this.lastName,
        this.phoneNumber,
        this.email,
        this.role,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.trips,
        this.vehicles,
        this.tickets,
        this.assignedRoutes,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        role: json["role"],
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        trips: json["trips"] == null ? [] : List<dynamic>.from(json["trips"]!.map((x) => x)),
        vehicles: json["vehicles"] == null ? [] : List<dynamic>.from(json["vehicles"]!.map((x) => x)),
        tickets: json["tickets"] == null ? [] : List<dynamic>.from(json["tickets"]!.map((x) => x)),
        assignedRoutes: json["assignedRoutes"] == null ? [] : List<dynamic>.from(json["assignedRoutes"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "email": email,
        "role": role,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "trips": trips == null ? [] : List<dynamic>.from(trips!.map((x) => x)),
        "vehicles": vehicles == null ? [] : List<dynamic>.from(vehicles!.map((x) => x)),
        "tickets": tickets == null ? [] : List<dynamic>.from(tickets!.map((x) => x)),
        "assignedRoutes": assignedRoutes == null ? [] : List<dynamic>.from(assignedRoutes!.map((x) => x)),
    };
}
