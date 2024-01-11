import 'package:bio_clean/core/use_cases/usecase.dart';
import 'package:bio_clean/feature/bio_clean/domain/entities/machine.dart';
import 'package:bio_clean/feature/bio_clean/domain/repositories/machine.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';

class UpdateMachine extends UseCase<Machine, Params> {
  final MachineRepository repository;

  UpdateMachine(this.repository);

  @override
  Future<Either<Failure, Machine>> call(Params params) async {
    return await repository.updateMachine(
        id: params.id,
        name: params.name,
        serialNumber: params.serialNumber,
        location: params.location,
        token: params.token);
  }
}

class Params extends Equatable {
  final String id;
  final String name;
  final String serialNumber;
  final String location;
  final String token;

  const Params({
    required this.id,
    required this.name,
    required this.serialNumber,
    required this.location,
    required this.token,
  });

  @override
  List<Object?> get props => [id, name, serialNumber, location, token];
}
