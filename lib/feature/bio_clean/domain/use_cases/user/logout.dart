import 'package:bio_clean/core/use_cases/usecase.dart';
import 'package:bio_clean/feature/bio_clean/domain/repositories/user.dart';
import 'package:either_dart/either.dart';

import '../../../../../core/errors/failure.dart';

class LogOut extends UseCase<void, NoParams> {
  final UserRepository repository;

  LogOut(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.logOut();
  }
}
