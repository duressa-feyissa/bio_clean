import 'package:bio_clean/core/network/info.dart';
import 'package:bio_clean/feature/bio_clean/data/data_source/local/user.dart';
import 'package:bio_clean/feature/bio_clean/data/data_source/remote/user.dart';
import 'package:bio_clean/feature/bio_clean/domain/use_cases/user/create.dart';
import 'package:bio_clean/feature/bio_clean/domain/use_cases/user/login.dart';
import 'package:bio_clean/feature/bio_clean/domain/use_cases/user/view.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/bio_clean/data/repositories/user.dart';
import 'feature/bio_clean/domain/repositories/user.dart';
import 'feature/bio_clean/domain/use_cases/user/logout.dart';
import 'feature/bio_clean/presentation/bloc/user/user_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features
  // - Problem
  sl.registerFactory(() => UserBloc(
        userCreate: sl(),
        userLogin: sl(),
        userGet: sl(),
        userLogout: sl(),
      ));

  // Use cases
  // - User
  sl.registerLazySingleton(() => UserLogin(sl()));
  sl.registerLazySingleton(() => CreateUser(sl()));
  sl.registerLazySingleton(() => GetUser(sl()));
  sl.registerLazySingleton(() => LogOut(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
        remoteDataSource: sl(), networkInfo: sl(), localDataSource: sl()),
  );

  // Data sources - Remote

  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(client: sl()),
  );

  // Data sources - Local
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
