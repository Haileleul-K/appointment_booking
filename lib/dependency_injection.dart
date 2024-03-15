import 'package:get_it/get_it.dart';
import 'package:skylightDemo/core/utils/api_service.dart';
import 'package:skylightDemo/core/utils/notification_service.dart';
import 'package:skylightDemo/features/auth/bloc/auth_bloc.dart';

import 'package:http/http.dart' as http;
import 'package:skylightDemo/features/auth/repository/auth_repo.dart';
import 'package:skylightDemo/features/home/bloc/add_service/add_service_bloc.dart';
import 'package:skylightDemo/features/home/bloc/delete_service/delete_service_bloc.dart';
import 'package:skylightDemo/features/home/bloc/get_service/service_bloc.dart';
import 'package:skylightDemo/features/home/repository/service_repo.dart';


GetIt sl = GetIt.instance;

Future<void> init() async {

  sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => InternetConnectionChecker());
//bloc
  sl.registerFactory(() => AuthBloc(sl()));
  sl.registerFactory(() => ServiceBloc(sl()));
  sl.registerFactory(() => AddServiceBloc(sl()));
  sl.registerFactory(() => DeleteServiceBloc(sl()));
  //network service

  sl.registerLazySingleton<ApiBaseHelper>(
      () => ApiBaseHelperImpl(client: sl()));
//Notification
  sl.registerLazySingleton(() => NotificationService());
  
  //repository

  sl.registerLazySingleton(
    () => AuthRepository(remoteDataSource: sl()),
  );

  sl.registerLazySingleton(
    () => ServiceRepository(remoteDataSource: sl()),
  );
}
