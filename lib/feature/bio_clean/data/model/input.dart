import 'package:bio_clean/feature/bio_clean/domain/entities/input.dart';

class InputModel extends Input {
  const InputModel({
    required String id,
    required String type,
    required double water,
    required double waste,
    required double methanol,
    required double bioGasProduction,
    required double waterProduction,
    required double currentBioGasProduction,
    required double currentWaterProduction,
    required String machineId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          type: type,
          water: water,
          waste: waste,
          methanol: methanol,
          bioGasProduction: bioGasProduction,
          waterProduction: waterProduction,
          currentBioGasProduction: currentBioGasProduction,
          currentWaterProduction: currentWaterProduction,
          machineId: machineId,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory InputModel.fromJson(Map<String, dynamic> json) {
    return InputModel(
      id: json['_id'],
      type: json['type'],
      water: json['water'].toDouble(),
      waste: json['waste'].toDouble(),
      bioGasProduction: json['bioGasProduction'].toDouble(),
      waterProduction: json['waterProduction'].toDouble(),
      currentBioGasProduction: json['currentBioGasProduction'].toDouble(),
      currentWaterProduction: json['currentWaterProduction'].toDouble(),
      methanol: json['methanol'].toDouble(),
      machineId: json['machineId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'water': water,
      'waste': waste,
      'methanol': methanol,
      'bioGasProduction': bioGasProduction,
      'waterProduction': waterProduction,
      'currentBioGasProduction': currentBioGasProduction,
      'currentWaterProduction': currentWaterProduction,
      'machineId': machineId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
