import 'package:bio_clean/feature/bio_clean/domain/entities/machine.dart';

class MachineModel extends Machine {
  const MachineModel({
    required String id,
    required String name,
    required String serialNumber,
    required String location,
    required String userId,
  }) : super(
          id: id,
          name: name,
          serialNumber: serialNumber,
          location: location,
          userId: userId,
        );

  factory MachineModel.fromJson(Map<String, dynamic> json) {
    return MachineModel(
      id: json['_id'],
      name: json['name'],
      serialNumber: json['serialNumber'],
      location: json['location'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'serialNumber': serialNumber,
      'location': location,
      'userId': userId,
    };
  }

  factory MachineModel.fromCache(Map<String, dynamic> json) {
    return MachineModel(
      id: json['id'],
      name: json['name'],
      serialNumber: json['serialNumber'],
      location: json['location'],
      userId: json['userId'],
    );
  }

  MachineModel copyWith({
    String? id,
    String? name,
    String? serialNumber,
    String? location,
    String? userId,
  }) {
    return MachineModel(
      id: id ?? this.id,
      name: name ?? this.name,
      serialNumber: serialNumber ?? this.serialNumber,
      location: location ?? this.location,
      userId: userId ?? this.userId,
    );
  }
}
