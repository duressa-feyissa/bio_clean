import 'package:bio_clean/core/use_cases/usecase.dart';
import 'package:bio_clean/feature/bio_clean/domain/entities/machine.dart';
import 'package:bio_clean/feature/bio_clean/domain/repositories/machine.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';

class GetMachines extends UseCase<List<Machine>, Params> {
  final MachineRepository repository;

  GetMachines(this.repository);

  @override
  Future<Either<Failure, List<Machine>>> call(Params params) async {
    return await repository.getMachines(
        userId: params.userId, machinesId: params.machinesId, token: params.token);
  }
}

class Params extends Equatable {
  final String userId;
  final List<String> machinesId;
  final String token;

  const Params({
    required this.userId,
    required this.machinesId,
    required this.token,
  });

  @override
  List<Object?> get props => [userId, token, machinesId];
}
