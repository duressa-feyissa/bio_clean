part of 'input_bloc.dart';

enum InputDeleteStatus { initial, loading, success, failure }

enum InputCreateStatus { initial, loading, success, failure }

enum InputUpdateStatus { initial, loading, success, failure }

enum InputGetStatus { initial, loading, success, failure }

enum InputGetAllStatus { initial, loading, success, failure }

class InputState extends Equatable {
  final InputDeleteStatus deleteStatus;
  final InputCreateStatus createStatus;
  final InputUpdateStatus updateStatus;
  final InputGetStatus getStatus;
  final InputGetAllStatus getAllStatus;
  final Input? input;
  final List<Input> inputs;
  const InputState({
    this.deleteStatus = InputDeleteStatus.initial,
    this.createStatus = InputCreateStatus.initial,
    this.updateStatus = InputUpdateStatus.initial,
    this.getStatus = InputGetStatus.initial,
    this.getAllStatus = InputGetAllStatus.initial,
    this.input,
    this.inputs = const [],
  });

  @override
  List<Object> get props => [
        deleteStatus,
        createStatus,
        updateStatus,
        getStatus,
        getAllStatus,
        inputs,
      ];

  InputState copyWith({
    InputDeleteStatus? deleteStatus,
    InputCreateStatus? createStatus,
    InputUpdateStatus? updateStatus,
    InputGetStatus? getStatus,
    InputGetAllStatus? getAllStatus,
    Input? input,
    List<Input>? inputs,
  }) {
    return InputState(
      deleteStatus: deleteStatus ?? this.deleteStatus,
      createStatus: createStatus ?? this.createStatus,
      updateStatus: updateStatus ?? this.updateStatus,
      getStatus: getStatus ?? this.getStatus,
      getAllStatus: getAllStatus ?? this.getAllStatus,
      input: input ?? this.input,
      inputs: inputs ?? this.inputs,
    );
  }
}
