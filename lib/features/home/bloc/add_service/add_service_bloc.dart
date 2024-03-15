

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:skylightDemo/features/home/data/service_model.dart';
import 'package:skylightDemo/features/home/repository/service_repo.dart';

part 'add_service_event.dart';
part 'add_service_state.dart';

class AddServiceBloc extends Bloc<AddServiceEvent, AddServiceState> {
  final ServiceRepository repository ;
  AddServiceBloc(this.repository) : super(AddServiceInitial()) {
    on<AddServiceEvent>((event, emit) async{
     emit(AddServiceInitial());
var response = await repository.addNewService({
          "title" :event.serviceTitle,
          "price" : event.servicePrice
        });
        response.fold((error) => {
         emit(AddServiceError(message: error))
        }, (response) =>{
          event.serviceData.insert(0, Services(service: response)),
          emit(AddServiceLoaded()),
         
        } );
    });
  }
}
