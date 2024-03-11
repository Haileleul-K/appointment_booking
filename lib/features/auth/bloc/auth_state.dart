part of 'auth_bloc.dart';

@immutable
class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final User userData;
  LoginSuccess({required this.userData});
}

class LoginError extends AuthState {
  final String errorMessage;
  LoginError ({required this.errorMessage});
}
