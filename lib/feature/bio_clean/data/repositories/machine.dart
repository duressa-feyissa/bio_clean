import 'package:bio_clean/core/errors/failure.dart';
import 'package:bio_clean/feature/bio_clean/data/data_source/local/machine.dart';
import 'package:bio_clean/feature/bio_clean/data/data_source/remote/machine.dart';
import 'package:bio_clean/feature/bio_clean/domain/entities/machine.dart';
import 'package:bio_clean/feature/bio_clean/domain/repositories/machine.dart';
import 'package:either_dart/either.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/network/info.dart';

class MachineRepositoryImpl extends MachineRepository {
  MachineRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final MachineRemoteDataSource remoteDataSource;
  final MachineLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Machine>> createMachine(
      {required String name,
      required String serialNumber,
      required String location,
      required String userId,
      required String token}) async {
    if (await networkInfo.isConnected) {
      try {
        final machine = await remoteDataSource.createMachine(
          name: name,
          serialNumber: serialNumber,
          location: location,
          userId: userId,
          token: token,
        );
        await localDataSource.cacheMachine([machine]);
        return Right(machine);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Machine>> deleteMachine(
      {required String id, required String token}) {
    // TODO: implement deleteMachine
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Machine>> getMachine(
      {required String id, required String token}) {
    // TODO: implement getMachine
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Machine>>> getMachines(
      {required String userId, required String token}) async {
    if (await networkInfo.isConnected) {
      try {
        final machines = await remoteDataSource.getMachines(
          userId: userId,
          token: token,
        );
        await localDataSource.cacheMachine(machines);
        return Right(machines);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final machines = await localDataSource.getMachine();
        return Right(machines);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Machine>> updateMachine(
      {required String id,
      required String name,
      required String serialNumber,
      required String location,
      required String token}) {
    // TODO: implement updateMachine
    throw UnimplementedError();
  }
}
