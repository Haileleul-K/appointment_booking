import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';
import 'package:skylightDemo/features/home/repository/service_repo.dart';

part 'delete_service_event.dart';
part 'delete_service_state.dart';

class DeleteServiceBloc extends Bloc<DeleteServiceEvent, DeleteServiceState> {
  ServiceRepository repository;
  DeleteServiceBloc(this.repository) : super(DeleteServiceInitial()) {
    on<DeleteServiceEvent>((event, emit) async {
      emit(DeleteServiceInitial());
      var response = await repository.deleteServiceItem(event.serviceItemId);
      response.fold(
          (error) => {emit(DeleteServiceError(message: error))},
          (response) => {
               emit(DeleteServicLoaded())
              });
    });
  }
}
