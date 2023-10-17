import 'package:dartz/dartz.dart';
import 'package:ticket_with_bloc/core/common.dart';
import 'package:ticket_with_bloc/core/utils/api_service.dart';
import 'package:ticket_with_bloc/features/auth/data/user_model.dart';

class AuthRepository {
  final ApiBaseHelper remoteDataSource;
  AuthRepository({required this.remoteDataSource});

  @override
  Future<Either<UserErrorResponse, UserModel>> login(login) async {
    // bool connected = await networkInfo.isConnected;

    var user = await remoteDataSource.login(login);
    print(user);
    return user.fold((error) => Left(error),
        (success) => Right(success));
  }
}
