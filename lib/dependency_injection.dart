import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_with_bloc/core/netService.dart';
import 'package:ticket_with_bloc/core/utils/api_service.dart';
import 'package:ticket_with_bloc/core/utils/shared_preference.dart';
import 'package:ticket_with_bloc/features/auth/bloc/auth_bloc.dart';
import 'package:ticket_with_bloc/features/auth/repository/auth_repo.dart';
import 'package:http/http.dart' as http;

GetIt sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => Storage());
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => InternetConnectionChecker());
//bloc
  sl.registerFactory(() => AuthBloc(sl()));
  //network service

  sl.registerLazySingleton<ApiBaseHelper>(
      () => ApiBaseHelperImpl(client: sl()));

  //repository

  sl.registerLazySingleton(
    () => AuthRepository(remoteDataSource: sl()),
  );
}
