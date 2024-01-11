import 'package:bio_clean/core/use_cases/usecase.dart';
import 'package:bio_clean/feature/bio_clean/domain/entities/machine.dart';
import 'package:bio_clean/feature/bio_clean/domain/repositories/machine.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';

class DeleteMachine extends UseCase<Machine, Params> {
  final MachineRepository repository;

  DeleteMachine(this.repository);

  @override
  Future<Either<Failure, Machine>> call(Params params) async {
    return await repository.deleteMachine(id: params.id, token: params.token);
  }
}

class Params extends Equatable {
  final String id;
  final String token;

  const Params({
    required this.id,
    required this.token,
  });

  @override
  List<Object?> get props => [id, token];
}
