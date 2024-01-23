import 'package:bio_clean/core/network/info.dart';
import 'package:bio_clean/feature/bio_clean/data/data_source/local/user.dart';
import 'package:bio_clean/feature/bio_clean/data/data_source/remote/user.dart';
import 'package:bio_clean/feature/bio_clean/data/repositories/input.dart';
import 'package:bio_clean/feature/bio_clean/data/repositories/machine.dart';
import 'package:bio_clean/feature/bio_clean/domain/repositories/machine.dart';
import 'package:bio_clean/feature/bio_clean/domain/use_cases/input/viiews.dart';
import 'package:bio_clean/feature/bio_clean/domain/use_cases/machine/update.dart';
import 'package:bio_clean/feature/bio_clean/domain/use_cases/machine/views.dart';
import 'package:bio_clean/feature/bio_clean/domain/use_cases/user/create.dart';
import 'package:bio_clean/feature/bio_clean/domain/use_cases/user/login.dart';
import 'package:bio_clean/feature/bio_clean/domain/use_cases/user/view.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/bio_clean/data/data_source/local/input.dart';
import 'feature/bio_clean/data/data_source/local/machine.dart';
import 'feature/bio_clean/data/data_source/remote/input.dart';
import 'feature/bio_clean/data/data_source/remote/machine.dart';
import 'feature/bio_clean/data/repositories/user.dart';
import 'feature/bio_clean/domain/repositories/input.dart';
import 'feature/bio_clean/domain/repositories/user.dart';
import 'feature/bio_clean/domain/use_cases/input/create.dart';
import 'feature/bio_clean/domain/use_cases/input/delete.dart';
import 'feature/bio_clean/domain/use_cases/input/update.dart';
import 'feature/bio_clean/domain/use_cases/input/view.dart';
import 'feature/bio_clean/domain/use_cases/machine/analysis.dart';
import 'feature/bio_clean/domain/use_cases/machine/create.dart';
import 'feature/bio_clean/domain/use_cases/machine/delete.dart';
import 'feature/bio_clean/domain/use_cases/machine/load.dart';
import 'feature/bio_clean/domain/use_cases/machine/save.dart';
import 'feature/bio_clean/domain/use_cases/machine/serial_delete.dart';
import 'feature/bio_clean/domain/use_cases/machine/view.dart';
import 'feature/bio_clean/domain/use_cases/user/logout.dart';
import 'feature/bio_clean/presentation/bloc/input/input_bloc.dart';
import 'feature/bio_clean/presentation/bloc/machine/machine_bloc.dart';
import 'feature/bio_clean/presentation/bloc/user/user_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features
  // - User
  sl.registerFactory(() => UserBloc(
        userCreate: sl(),
        userLogin: sl(),
        userGet: sl(),
        userLogout: sl(),
      ));

  // - Machine
  sl.registerFactory(() => MachineBloc(
        createMachine: sl(),
        getMachine: sl(),
        deleteMachine: sl(),
        getMachines: sl(),
        updateMachine: sl(),
        loadMachine: sl(),
        saveMachine: sl(),
        deleteBySerial: sl(),
        analysisMachine: sl(),
      ));

  // - Input
  sl.registerFactory(() => InputBloc(
        createInput: sl(),
        deleteInput: sl(),
        getInput: sl(),
        getInputs: sl(),
        updateInput: sl(),
      ));

  // Use cases
  // - User
  sl.registerLazySingleton(() => UserLogin(sl()));
  sl.registerLazySingleton(() => CreateUser(sl()));
  sl.registerLazySingleton(() => GetUser(sl()));
  sl.registerLazySingleton(() => LogOut(sl()));

  // Machine
  sl.registerLazySingleton(() => CreateMachine(sl()));
  sl.registerLazySingleton(() => GetMachine(sl()));
  sl.registerLazySingleton(() => DeleteMachine(sl()));
  sl.registerLazySingleton(() => GetMachines(sl()));
  sl.registerLazySingleton(() => UpdateMachine(sl()));
  sl.registerLazySingleton(() => LoadMachine(sl()));
  sl.registerLazySingleton(() => SaveMachine(sl()));
  sl.registerLazySingleton(() => DeleteBySerial(sl()));
  sl.registerLazySingleton(() => AnalysisMachine(sl()));

  // Input
  sl.registerLazySingleton(() => CreateInput(sl()));
  sl.registerLazySingleton(() => DeleteInput(sl()));
  sl.registerLazySingleton(() => ViewInput(sl()));
  sl.registerLazySingleton(() => ViewInputs(sl()));
  sl.registerLazySingleton(() => UpdateInput(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
        remoteDataSource: sl(), networkInfo: sl(), localDataSource: sl()),
  );

  sl.registerLazySingleton<MachineRepository>(
    () => MachineRepositoryImpl(
        remoteDataSource: sl(), networkInfo: sl(), localDataSource: sl()),
  );

  sl.registerLazySingleton<InputRepository>(
    () => InputRepositoryImpl(
        remoteDataSource: sl(), networkInfo: sl(), localDataSource: sl()),
  );

  // Data sources - Remote

  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<MachineRemoteDataSource>(
    () => MachineRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<InputRemoteDataSource>(
    () => InputRemoteDataSourceImpl(client: sl()),
  );

  // Data sources - Local
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<MachineLocalDataSource>(
    () => MachineLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<InputLocalDataSource>(
    () => InputLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
