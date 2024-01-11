import 'package:bio_clean/core/errors/failure.dart';
import 'package:bio_clean/feature/bio_clean/domain/entities/machine.dart';
import 'package:either_dart/either.dart';

abstract class MachineRepository {
  Future<Either<Failure, Machine>> getMachine({
    required String id,
    required String token,
  });

  Future<Either<Failure, List<Machine>>> getMachines({
    required String userId,
    required String token,
  });

  Future<Either<Failure, Machine>> createMachine({
    required String name,
    required String serialNumber,
    required String location,
    required String userId,
    required String token,
  });

  Future<Either<Failure, Machine>> updateMachine({
    required String id,
    required String name,
    required String serialNumber,
    required String location,
    required String token,
  });

  Future<Either<Failure, Machine>> deleteMachine({
    required String id,
    required String token,
  });
}
