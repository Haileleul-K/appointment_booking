// To parse this JSON data, do
//
//     final vehicles = vehiclesFromJson(jsonString);

import 'dart:convert';

List<Vehicles> vehiclesFromJson(String str) => List<Vehicles>.from(json.decode(str).map((x) => Vehicles.fromJson(x)));

String vehiclesToJson(List<Vehicles> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Vehicles {
    String? id;
    String? name;
    String? vehicleLevel;
    String? plateNumber;
    String? sideNumber;
    int? totalSeats;
    String? status;
    int? vehicleTypeId;
    String? createdById;
    String? updatedById;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    List<Trip>? trips;

    Vehicles({
        this.id,
        this.name,
        this.vehicleLevel,
        this.plateNumber,
        this.sideNumber,
        this.totalSeats,
        this.status,
        this.vehicleTypeId,
        this.createdById,
        this.updatedById,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.trips,
    });

    factory Vehicles.fromJson(Map<String, dynamic> json) => Vehicles(
        id: json["id"],
        name: json["name"],
        vehicleLevel: json["vehicleLevel"],
        plateNumber: json["plateNumber"],
        sideNumber: json["sideNumber"],
        totalSeats: json["totalSeats"],
        status: json["status"],
        vehicleTypeId: json["vehicleTypeId"],
        createdById: json["createdById"],
        updatedById: json["updatedById"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        trips: json["trips"] == null ? [] : List<Trip>.from(json["trips"]!.map((x) => Trip.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "vehicleLevel": vehicleLevel,
        "plateNumber": plateNumber,
        "sideNumber": sideNumber,
        "totalSeats": totalSeats,
        "status": status,
        "vehicleTypeId": vehicleTypeId,
        "createdById": createdById,
        "updatedById": updatedById,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "trips": trips == null ? [] : List<dynamic>.from(trips!.map((x) => x.toJson())),
    };
}

class Trip {
    String? id;
    String? userId;
    String? routeId;
    String? vehicleId;
    int? tarrifAmount;
    int? vehicleCapacity;
    String? shortCode;
    String? status;
    DateTime? tripLocalDate;
    String? createdById;
    String? updatedById;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;

    Trip({
        this.id,
        this.userId,
        this.routeId,
        this.vehicleId,
        this.tarrifAmount,
        this.vehicleCapacity,
        this.shortCode,
        this.status,
        this.tripLocalDate,
        this.createdById,
        this.updatedById,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        id: json["id"],
        userId: json["userId"],
        routeId: json["routeId"],
        vehicleId: json["vehicleId"],
        tarrifAmount: json["tarrifAmount"],
        vehicleCapacity: json["vehicleCapacity"],
        shortCode: json["shortCode"],
        status: json["status"],
        tripLocalDate: json["tripLocalDate"] == null ? null : DateTime.parse(json["tripLocalDate"]),
        createdById: json["createdById"],
        updatedById: json["updatedById"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "routeId": routeId,
        "vehicleId": vehicleId,
        "tarrifAmount": tarrifAmount,
        "vehicleCapacity": vehicleCapacity,
        "shortCode": shortCode,
        "status": status,
        "tripLocalDate": tripLocalDate?.toIso8601String(),
        "createdById": createdById,
        "updatedById": updatedById,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
    };
}
