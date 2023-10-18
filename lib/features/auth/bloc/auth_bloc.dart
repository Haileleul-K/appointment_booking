import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:ticket_with_bloc/core/common.dart';
import 'package:ticket_with_bloc/features/auth/data/user_model.dart';
import 'package:ticket_with_bloc/features/auth/repository/auth_repo.dart';

import '../../../core/utils/shared_preference.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository repository;
  AuthBloc(this.repository) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      Logger().w('Bloc get called');
      emit(LoginLoading());
      final login = jsonEncode({
        "data": {"email": event.email, "password": event.password}
      });

      dynamic response = await repository.login(login);
      response.fold((failure) {
        
        Left(emit(LoginError(errorMessage: failure)));
        
      }, (success) {
       //Storage.setString('accessToken', success['token']);
        emit(LoginSuccess(userData: success));
      });
    });
  }
}
