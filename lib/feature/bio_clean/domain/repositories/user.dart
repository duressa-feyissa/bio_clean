import 'package:bio_clean/core/errors/failure.dart';
import 'package:bio_clean/feature/bio_clean/domain/entities/user.dart';
import 'package:either_dart/either.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> login(
      {required String phone, required String password});
  Future<Either<Failure, User>> getUser();
  Future<Either<Failure, User>> createUser({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
  });

  Future<Either<Failure, void>> logOut();
}
