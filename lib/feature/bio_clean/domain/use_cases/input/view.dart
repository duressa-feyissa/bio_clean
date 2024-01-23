import 'package:bio_clean/core/errors/failure.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/use_cases/usecase.dart';
import '../../entities/input.dart';
import '../../repositories/input.dart';

class ViewInput extends UseCase<Input, Params> {
  final InputRepository repository;

  ViewInput(this.repository);

  @override
  Future<Either<Failure, Input>> call(Params params) async {
    return await repository.getInput(
      id: params.id,
      token: params.token,
    );
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
