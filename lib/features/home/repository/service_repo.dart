import 'package:dartz/dartz.dart';
import 'package:skylightDemo/core/utils/api_service.dart';
import 'package:skylightDemo/features/home/data/service_model.dart';

class ServiceRepository {
  final ApiBaseHelper remoteDataSource;
  ServiceRepository({required this.remoteDataSource});

  Future<Either<dynamic, List<Services>>> getServiceData() async {
    // bool connected = await networkInfo.isConnected;

    var serviceData = await remoteDataSource.getServices();
    
    return serviceData.fold((error) => Left(error),
        (success) => Right(success));
  }
   Future<Either<dynamic, dynamic>> deleteServiceItem(String serviceId) async {
    // bool connected = await networkInfo.isConnected;

    var serviceData = await remoteDataSource.deleteService(serviceId);
    
    return serviceData.fold((error) => Left(error),
        (success) => Right(success));
  }
   Future<Either<dynamic, dynamic>> addNewService(Map<String,dynamic> data) async {
    // bool connected = await networkInfo.isConnected;

    var serviceData = await remoteDataSource.addNewService(data);
    
    return serviceData.fold((error) => Left(error),
        (success) => Right(success));
  }
}
