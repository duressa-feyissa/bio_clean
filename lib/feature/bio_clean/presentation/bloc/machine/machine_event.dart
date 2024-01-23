part of 'machine_bloc.dart';

sealed class MachineEvent extends Equatable {
  const MachineEvent();

  @override
  List<Object> get props => [];
}

class MachineDeleteEvent extends MachineEvent {
  final String id;
  final String token;

  const MachineDeleteEvent({
    required this.id,
    required this.token,
  });

  @override
  List<Object> get props => [id, token];
}

class MachineCreateEvent extends MachineEvent {
  final String name;
  final String userId;
  final String serialNumber;
  final String location;
  final String token;

  const MachineCreateEvent({
    required this.name,
    required this.userId,
    required this.serialNumber,
    required this.location,
    required this.token,
  });

  @override
  List<Object> get props => [name, userId, serialNumber, location, token];
}

class MachineUpdateEvent extends MachineEvent {
  final String id;
  final String name;

  final String serialNumber;
  final String location;
  final String token;

  const MachineUpdateEvent({
    required this.id,
    required this.name,
    required this.serialNumber,
    required this.location,
    required this.token,
  });

  @override
  List<Object> get props => [id, name, serialNumber, location, token];
}

class MachineGetEvenet extends MachineEvent {
  final String id;
  final String token;

  const MachineGetEvenet({
    required this.id,
    required this.token,
  });

  @override
  List<Object> get props => [id, token];
}

class MachineGetAllEvent extends MachineEvent {
  final String token;
  final String userId;
  final List<String> machinesId;

  const MachineGetAllEvent({
    required this.token,
    required this.userId,
    required this.machinesId,
  });

  @override
  List<Object> get props => [token, userId, machinesId];
}

class LoadMachinesSerialEvent extends MachineEvent {
  const LoadMachinesSerialEvent();
}

class SaveMachinesSerialEvent extends MachineEvent {
  final List<String> ids;

  const SaveMachinesSerialEvent({
    required this.ids,
  });

  @override
  List<Object> get props => [ids];
}

class DeleteMachineSerialEvent extends MachineEvent {
  final String id;

  const DeleteMachineSerialEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class ClearMachine extends MachineEvent {
  const ClearMachine();
}

class AnalysisMachineSerialEvent extends MachineEvent {
  final String id;
  final String token;

  const AnalysisMachineSerialEvent({
    required this.id,
    required this.token,
  });

  @override
  List<Object> get props => [id, token];
}
