import 'package:bio_clean/core/errors/exception.dart';
import 'package:bio_clean/core/errors/failure.dart';
import 'package:bio_clean/feature/bio_clean/data/data_source/local/input.dart';
import 'package:bio_clean/feature/bio_clean/domain/entities/input.dart';
import 'package:either_dart/either.dart';

import '../../../../core/network/info.dart';
import '../../domain/repositories/input.dart';
import '../data_source/remote/input.dart';

class InputRepositoryImpl extends InputRepository {
  InputRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final InputRemoteDataSource remoteDataSource;
  final InputLocalDataSource localDataSource;

  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Input>> create(
      {required String machineId,
      required String type,
      required double water,
      required double waste,
      required double methanol,
      required String token}) async {
    if (await networkInfo.isConnected) {
      try {
        final input = await remoteDataSource.create(
            machineId: machineId,
            type: type,
            water: water,
            waste: waste,
            methanol: methanol,
            token: token);

        return Right(input);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Input>> delete(
      {required String id, required String token}) async {
    if (await networkInfo.isConnected) {
      try {
        final input = await remoteDataSource.delete(id: id, token: token);
        return Right(input);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Input>> getInput(
      {required String id, required String token}) async {
    if (await networkInfo.isConnected) {
      try {
        final input = await remoteDataSource.getInput(id: id, token: token);
        return Right(input);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Input>>> getInputs(
      {required String id, required String token}) async {
    if (await networkInfo.isConnected) {
      try {
        final input = await remoteDataSource.getInputs(id: id, token: token);
        await localDataSource.cacheMachine(input);
        return Right(input);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final input = await localDataSource.getInputs();
        return Right(input);
      } on CacheException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Input>> update(
      {required String id,
      required String type,
      required double water,
      required double waste,
      required double methanol,
      required String token}) async {
    if (await networkInfo.isConnected) {
      try {
        final input = await remoteDataSource.update(
            id: id,
            type: type,
            water: water,
            waste: waste,
            methanol: methanol,
            token: token);

        return Right(input);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
