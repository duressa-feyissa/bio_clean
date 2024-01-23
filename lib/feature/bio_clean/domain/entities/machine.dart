import 'package:equatable/equatable.dart';

class Machine extends Equatable {
  final String id;
  final String name;
  final String serialNumber;
  final String location;
  final String userId;

  const Machine({
    required this.id,
    required this.name,
    required this.serialNumber,
    required this.location,
    required this.userId,
  });

  @override
  List<Object> get props => [id, name, serialNumber, location, userId];
}
