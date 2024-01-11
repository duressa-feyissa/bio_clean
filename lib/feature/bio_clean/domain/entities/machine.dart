import 'package:equatable/equatable.dart';

class Machine extends Equatable {
  final String id;
  final String name;
  final String serialNumber;
  final String location;

  const Machine({
    required this.id,
    required this.name,
    required this.serialNumber,
    required this.location,
  });

  @override
  List<Object> get props => [id, name, serialNumber, location];
}
