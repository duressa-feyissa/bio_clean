import 'package:bio_clean/core/use_cases/usecase.dart';
import 'package:bio_clean/feature/bio_clean/domain/entities/input.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../repositories/input.dart';

class CreateInput extends UseCase<Input, Params> {
  final InputRepository repository;

  CreateInput(this.repository);

  @override
  Future<Either<Failure, Input>> call(Params params) async {
    return await repository.create(
      machineId: params.machineId,
      type: params.type,
      water: params.water,
      waste: params.waste,
      methanol: params.methanol,
      token: params.token,
    );
  }
}

class Params extends Equatable {
  final String machineId;
  final String type;
  final double water;
  final double waste;
  final double methanol;
  final String token;

  const Params({
    required this.machineId,
    required this.type,
    required this.water,
    required this.waste,
    required this.methanol,
    required this.token,
  });

  @override
  List<Object?> get props => [machineId, type, water, waste, methanol, token];
}
