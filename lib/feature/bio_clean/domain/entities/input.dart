import 'package:equatable/equatable.dart';

class Input extends Equatable {
  final String id;
  final String type;
  final double water;
  final double waste;
  final double methanol;
  final double bioGasProduction;
  final double waterProduction;
  final double currentBioGasProduction;
  final double currentWaterProduction;
  final String machineId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Input({
    required this.id,
    required this.type,
    required this.water,
    required this.waste,
    required this.methanol,
    required this.bioGasProduction,
    required this.waterProduction,
    required this.currentBioGasProduction,
    required this.currentWaterProduction,
    required this.machineId,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        water,
        waste,
        methanol,
        createdAt,
        updatedAt,
        bioGasProduction,
        waterProduction,
        machineId,
        currentBioGasProduction,
        currentWaterProduction
      ];
}
