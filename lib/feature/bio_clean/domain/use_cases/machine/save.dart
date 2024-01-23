import 'package:bio_clean/core/use_cases/usecase.dart';
import 'package:bio_clean/feature/bio_clean/domain/repositories/machine.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';

class SaveMachine extends UseCase<void, Params> {
  final MachineRepository repository;

  SaveMachine(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.saveMachine(ids: params.ids);
  }
}

class Params extends Equatable {
  final List<String> ids;

  const Params({
    required this.ids,
  });

  @override
  List<Object?> get props => [ids];
}
