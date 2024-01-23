import 'package:bio_clean/core/use_cases/usecase.dart';
import 'package:bio_clean/feature/bio_clean/domain/repositories/machine.dart';
import 'package:either_dart/either.dart';

import '../../../../../core/errors/failure.dart';

class LoadMachine extends UseCase<List<String>, NoParams> {
  final MachineRepository repository;

  LoadMachine(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    return await repository.loadIds();
  }
}
