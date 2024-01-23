part of 'input_bloc.dart';

sealed class InputEvent extends Equatable {
  const InputEvent();

  @override
  List<Object> get props => [];
}

class InputCreateEvent extends InputEvent {
  final String token;
  final String type;
  final double water;
  final double waste;
  final double methanol;
  final String machineId;

  const InputCreateEvent({
    required this.token,
    required this.type,
    required this.water,
    required this.waste,
    required this.methanol,
    required this.machineId,
  });

  @override
  List<Object> get props => [token, type, water, waste, methanol, machineId];
}

class InputUpdateEvent extends InputEvent {
  final String token;
  final String id;
  final String type;
  final double water;
  final double waste;
  final double methanol;

  const InputUpdateEvent({
    required this.token,
    required this.id,
    required this.type,
    required this.water,
    required this.waste,
    required this.methanol,
  });

  @override
  List<Object> get props => [token, id, type, water, waste, methanol];
}

class InputDeleteEvent extends InputEvent {
  final String token;
  final String id;

  const InputDeleteEvent({
    required this.token,
    required this.id,
  });

  @override
  List<Object> get props => [token, id];
}

class InputViewEvent extends InputEvent {
  final String token;
  final String id;

  const InputViewEvent({
    required this.token,
    required this.id,
  });

  @override
  List<Object> get props => [token, id];
}

class InputViewAllEvent extends InputEvent {
  final String machineId;
  final String token;

  const InputViewAllEvent({
    required this.machineId,
    required this.token,
  });

  @override
  List<Object> get props => [token, machineId];
}
