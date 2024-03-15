import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:skylightDemo/features/auth/data/user_model.dart';
import 'package:skylightDemo/features/auth/repository/auth_repo.dart';

import '../../../core/utils/hive_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository repository;
  AuthBloc(this.repository) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());
      // final login = jsonEncode({
      //   "data": {"email": event.email, "password": event.password}
      // });

      dynamic response = await repository.login(event.userID,event.role);
      response.fold((failure) {
        
        Left(emit(LoginError(errorMessage: failure)));
        
      }, (success) {
        emit(LoginSuccess(userData: success));
      });
    });
  }
}
