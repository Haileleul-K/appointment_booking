part of 'service_bloc.dart';

@immutable
 class ServiceState {}

 class ServiceInitial extends ServiceState {}
class ServiceLoaded extends ServiceState{
  final List<Services> serviceData ;
  ServiceLoaded({
    required this.serviceData
  });
}

class ServiceLoadingError extends ServiceState{
  final String error;
  ServiceLoadingError({required this.error});
}

