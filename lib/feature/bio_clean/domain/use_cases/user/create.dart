import 'package:bio_clean/core/use_cases/usecase.dart';
import 'package:bio_clean/feature/bio_clean/domain/entities/user.dart';
import 'package:bio_clean/feature/bio_clean/domain/repositories/user.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';

class CreateUser extends UseCase<User, Params> {
  final UserRepository repository;

  CreateUser(this.repository);

  @override
  Future<Either<Failure, User>> call(Params params) async {
    return await repository.createUser(
        firstName: params.firstName,
        lastName: params.lastName,
        phone: params.phone,
        password: params.password);
  }
}

class Params extends Equatable {
  final String firstName;
  final String lastName;
  final String phone;
  final String password;

  const Params({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.password,
  });

  @override
  List<Object?> get props => [firstName, lastName, phone, password];
}
