import 'package:bio_clean/core/use_cases/usecase.dart';
import 'package:bio_clean/feature/bio_clean/domain/repositories/machine.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';

class DeleteBySerial extends UseCase<void, Params> {
  final MachineRepository repository;

  DeleteBySerial(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.deleteSerial(id: params.id);
  }
}

class Params extends Equatable {
  final String id;

  const Params({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
