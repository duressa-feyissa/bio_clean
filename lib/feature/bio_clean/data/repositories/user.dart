import 'package:bio_clean/core/errors/exception.dart';
import 'package:bio_clean/core/errors/failure.dart';
import 'package:bio_clean/feature/bio_clean/data/data_source/local/user.dart';
import 'package:bio_clean/feature/bio_clean/data/data_source/remote/user.dart';
import 'package:bio_clean/feature/bio_clean/domain/entities/user.dart';
import 'package:bio_clean/feature/bio_clean/domain/repositories/user.dart';
import 'package:either_dart/either.dart';

import '../../../../core/network/info.dart';

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, User>> createUser(
      {required String firstName,
      required String lastName,
      required String phone,
      required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.createUser(
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          password: password,
        );

        return Right(user);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      final user = await localDataSource.getUser();
      return Right(user);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> login(
      {required String phone, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await remoteDataSource.login(
          phone,
          password,
        );
        final user = await remoteDataSource.getUser(token);

        user.copyWith(token: token);
        await localDataSource.cacheUser(user);

        return Right(user);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
