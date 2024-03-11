import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:ticket_with_bloc/core/common.dart';
import 'package:ticket_with_bloc/dependency_injection.dart';
import 'package:ticket_with_bloc/features/auth/data/user_model.dart';

abstract class ApiBaseHelper {
  Future<Either<dynamic, dynamic>> login(String userID,String role);
}

class ApiBaseHelperImpl implements ApiBaseHelper {
  final http.Client client;
  ApiBaseHelperImpl({required this.client});
  @override
  Future<Either<dynamic, User>> login(String userID,String role) async {

  final response;
    try {
      response = await client.get(
          headers: {"Content-Type": "application/json",
          "authorization": "Bearer ${AppConstants.APIKEY}"
          },
          Uri.parse('${AppConstants.baseUrl}client/users/$userID'),
          );
          Logger().i(response.body);
    }
    catch (er) {
      Logger().i('$er');
      return Left(
          'Error $er');
    }
      if (response.statusCode == 200) {
        print('${response.body}');
      if(userFromJson(response.body).clientUserLink.role.trim() != role.trim()){
        return Left('Try with other role! Role miss-match');
      }
      return Right(userFromJson(response.body));
      } else {
        return Left(jsonDecode(response.body)['error']['description']);
      }
    } 
  }

