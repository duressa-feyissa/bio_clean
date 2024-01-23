import 'package:either_dart/either.dart';

import '../../../../core/errors/failure.dart';
import '../entities/input.dart';

abstract class InputRepository {
  Future<Either<Failure, Input>> getInput({
    required String id,
    required String token,
  });
  Future<Either<Failure, List<Input>>> getInputs({
    required String id,
    required String token,
  });
  Future<Either<Failure, Input>> delete({
    required String id,
    required String token,
  });
  Future<Either<Failure, Input>> create({
    required String machineId,
    required String type,
    required double water,
    required double waste,
    required double methanol,
    required String token,
  });
  Future<Either<Failure, Input>> update({
    required String id,
    required String type,
    required double water,
    required double waste,
    required double methanol,
    required String token,
  });
}
