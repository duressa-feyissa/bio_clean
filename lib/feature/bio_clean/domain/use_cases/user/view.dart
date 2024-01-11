import 'package:bio_clean/core/use_cases/usecase.dart';
import 'package:bio_clean/feature/bio_clean/domain/entities/user.dart';
import 'package:bio_clean/feature/bio_clean/domain/repositories/user.dart';
import 'package:either_dart/either.dart';

import '../../../../../core/errors/failure.dart';

class GetUser extends UseCase<User, NoParams> {
  final UserRepository repository;

  GetUser(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getUser();
  }
}
