import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skylightDemo/features/home/data/service_model.dart';
import 'package:skylightDemo/features/home/repository/service_repo.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceRepository repository;
  ServiceBloc(this.repository) : super(ServiceInitial()) {
    on<ServiceEvent>((event, emit) async{
      if(event is GetServices){
        emit(ServiceInitial());
        var response = await repository.getServiceData();
        response.fold((error) => emit(ServiceLoaded(serviceData: error)), (response) => emit (ServiceLoaded(serviceData: response)));
      }
    });
  }
}
