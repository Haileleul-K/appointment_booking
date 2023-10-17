import 'dart:convert';

import 'package:flutter/material.dart';

final formkey = GlobalKey<FormState>();

class AppConstants {
  static final baseUrl = 'https://eticket.filanx.com/api/';
}


UserErrorResponse userErrorResponseFromJson(String str) => UserErrorResponse.fromJson(json.decode(str));

String userErrorResponseToJson(UserErrorResponse data) => json.encode(data.toJson());

class UserErrorResponse {
    String? message;
    String? error;

    UserErrorResponse({
        this.message,
        this.error,
    });

    factory UserErrorResponse.fromJson(Map<String, dynamic> json) => UserErrorResponse(
        message: json["message"],
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
    };
}