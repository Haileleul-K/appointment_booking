import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:skylightDemo/core/common.dart';
import 'package:skylightDemo/features/auth/data/user_model.dart';
import 'package:skylightDemo/features/home/data/service_model.dart';


abstract class ApiBaseHelper {
  Future<Either<dynamic, dynamic>> login(String userID, String role);
  Future<Either<dynamic, List<Services>>> getServices();
  Future<Either<dynamic, dynamic>> deleteService(String serviceId);
  Future<Either<dynamic, dynamic>> addNewService(Map<String, dynamic> data);
}

class ApiBaseHelperImpl implements ApiBaseHelper {
  final http.Client client;
  ApiBaseHelperImpl({required this.client});
  @override
  Future<Either<dynamic, User>> login(String userID, String role) async {
    final response;
    try {
      response = await client.get(
        headers: {
          "Content-Type": "application/json",
          "authorization": "Bearer ${AppConstants.APIKEY}"
        },
        Uri.parse('${AppConstants.baseUrl}client/users/$userID'),
      );
      Logger().i(response.body);
    } catch (er) {
      Logger().i('$er');
      return Left('Error $er');
    }
    if (response.statusCode == 200) {
      print('${response.body}');
      if (userFromJson(response.body).clientUserLink?.role?.trim() !=
          role.trim()) {
        return Left('Try with other role! Role miss-match');
      }
      return Right(userFromJson(response.body));
    } else {
      return Left(jsonDecode(response.body)['error']['description']);
    }
  }

  @override
  Future<Either<dynamic, List<Services>>> getServices() async {
    final response;
    try {
      response = await client.get(
        headers: {
          "Content-Type": "application/json",
          "authorization": "Bearer ${AppConstants.APIKEY}"
        },
        Uri.parse('${AppConstants.baseUrl}/services'),
      );
    } catch (er) {
      Logger().i('$er');
      return Left('Error $er');
    }
    if (response.statusCode == 200) {
      print('${response.body}');

      return Right(servicesFromJson(response.body));
    } else {
      return Left(jsonDecode(response.body)['error']['description']);
    }
  }

  @override
  Future<Either<dynamic, dynamic>> deleteService(String serviceId) async {
    final response;
    try {
      response = await client.delete(
        headers: {
          "Content-Type": "application/json",
          "authorization": "Bearer ${AppConstants.APIKEY}"
        },
        Uri.parse('${AppConstants.baseUrl}/services/$serviceId'),
      );
    } catch (er) {
      Logger().i('$er');
      return Left('Error $er');
    }
    if (response.statusCode == 200) {
      print('${response.body}');

      return Right(Service.fromJson(jsonDecode(response.body)['service']));
    } else {
      return Left(jsonDecode(response.body)['error']['description']);
    }
  }

  @override
  Future<Either<dynamic, dynamic>> addNewService(
      Map<String, dynamic> data) async {
    final response;

    try {
      response = await client.post(
        headers: {
          "Content-Type": "application/json",
          "authorization": "Bearer ${AppConstants.APIKEY}"
        },
        Uri.parse('${AppConstants.baseUrl}/services'),
        body: jsonEncode(data)
      );
    } catch (er) {
      Logger().i('$er');
      return Left('Error $er');
    }
    if (response.statusCode == 200) {
      
      Logger().w('${jsonDecode(response.body)['service']}');

      return Right(Service.fromJson(jsonDecode(response.body)['service']));
    } else {
      Logger().w(response.body);
      return Left(jsonDecode(response.body));
    }
  }
}
