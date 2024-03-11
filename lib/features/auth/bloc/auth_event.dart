part of 'auth_bloc.dart';

@immutable
class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String userID;
  final String role;
  // final String email;
  // final String password;
  LoginEvent({required this.userID,required this.role});
}
