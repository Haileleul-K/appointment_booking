import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:ticket_with_bloc/core/common.dart';
import 'package:ticket_with_bloc/features/auth/data/user_model.dart';

abstract class ApiBaseHelper {
  Future<Either<dynamic, dynamic>> login(loginModel);
}

class ApiBaseHelperImpl implements ApiBaseHelper {
  final http.Client client;
  ApiBaseHelperImpl({required this.client});
  @override
  Future<Either<UserErrorResponse, UserModel>> login(loginModel) async {

  final response;
    try {
      response = await client.post(
          headers: {"Content-Type": "application/json",
          "X-Imunify360-Agent": 'value'
          },
          Uri.parse('${AppConstants.baseUrl}auth/signin'),
          body: loginModel);
      Logger().w('${response.statusCode}');
      Logger().w('${response.body}');
    }
    catch (er) {
      return Left(
          UserErrorResponse(message: 'error happend', error: 'Some thing bad'));
    }

      if (response.statusCode == 200) {
        print('${response.body}');
        return Right(userModelFromJson(response.body));
      } else {
        return Left(userErrorResponseFromJson(response.body));
      }
    } 
  }

