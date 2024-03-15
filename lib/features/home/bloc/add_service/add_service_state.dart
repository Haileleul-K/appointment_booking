part of 'add_service_bloc.dart';

@immutable
 class AddServiceState {}

 class AddServiceInitial extends AddServiceState {}
 class AddServiceLoaded extends AddServiceState {}
 class AddServiceError extends AddServiceState {
  final String message;
  AddServiceError({required this.message});
 }
