part of 'add_service_bloc.dart';

@immutable
class AddServiceEvent {
  final List<Services> serviceData ;
final String serviceTitle;
final int servicePrice ;
AddServiceEvent({required this.serviceData, required this.servicePrice,required this.serviceTitle});
}
