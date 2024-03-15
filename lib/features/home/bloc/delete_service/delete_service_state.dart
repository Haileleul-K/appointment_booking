part of 'delete_service_bloc.dart';

@immutable
 class DeleteServiceState {}

 class DeleteServiceInitial extends DeleteServiceState {}


class DeleteServicLoaded extends DeleteServiceState{
}

class DeleteServiceError extends DeleteServiceState{
  final String message;
  DeleteServiceError({required this.message});
}