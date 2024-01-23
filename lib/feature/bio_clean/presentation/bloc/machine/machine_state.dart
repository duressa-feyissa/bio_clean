part of 'machine_bloc.dart';

enum MachineDeleteStatus { initial, loading, success, failure }

enum MachineCreateStatus { initial, loading, success, failure }

enum MachineUpdateStatus { initial, loading, success, failure }

enum MachineGetStatus { initial, loading, success, failure }

enum MachineGetAllStatus { initial, loading, success, failure }

enum MachineSerialSaveStatus { initial, loading, success, failure }

enum MachineSerialLoadStatus { initial, loading, success, failure }

enum MachineDeleteSerialStatus { initial, loading, success, failure }

enum MachineAnalysisStatus { initial, loading, success, failure }

class MachineState extends Equatable {
  final MachineDeleteStatus deleteStatus;
  final MachineCreateStatus createStatus;
  final MachineUpdateStatus updateStatus;
  final MachineGetStatus getStatus;
  final MachineGetAllStatus getAllStatus;
  final MachineSerialSaveStatus serialSaveStatus;
  final MachineSerialLoadStatus serialLoadStatus;
  final MachineDeleteSerialStatus deleteSerialStatus;
  final List<String> serials;
  final Machine? machine;
  final List<Machine> machines;
  final MachineAnalysisStatus analysisStatus;
  final String analysis;

  const MachineState({
    this.deleteStatus = MachineDeleteStatus.initial,
    this.createStatus = MachineCreateStatus.initial,
    this.updateStatus = MachineUpdateStatus.initial,
    this.getStatus = MachineGetStatus.initial,
    this.getAllStatus = MachineGetAllStatus.initial,
    this.serialSaveStatus = MachineSerialSaveStatus.initial,
    this.serialLoadStatus = MachineSerialLoadStatus.initial,
    this.deleteSerialStatus = MachineDeleteSerialStatus.initial,
    this.serials = const [],
    this.machine,
    this.machines = const [],
    this.analysisStatus = MachineAnalysisStatus.initial,
    this.analysis = '',
  });

  @override
  List<Object> get props => [
        deleteStatus,
        createStatus,
        updateStatus,
        getStatus,
        getAllStatus,
        machines,
        serialSaveStatus,
        deleteSerialStatus,
        serialLoadStatus,
        serials,
        analysisStatus,
        analysis
      ];

  MachineState copyWith({
    MachineDeleteStatus? deleteStatus,
    MachineCreateStatus? createStatus,
    MachineUpdateStatus? updateStatus,
    MachineGetStatus? getStatus,
    MachineGetAllStatus? getAllStatus,
    MachineSerialSaveStatus? serialSaveStatus,
    MachineSerialLoadStatus? serialLoadStatus,
    MachineDeleteSerialStatus? deleteSerialStatus,
    List<String>? serials,
    Machine? machine,
    List<Machine>? machines,
    MachineAnalysisStatus? analysisStatus,
    String? analysis,
  }) {
    return MachineState(
      deleteStatus: deleteStatus ?? this.deleteStatus,
      createStatus: createStatus ?? this.createStatus,
      updateStatus: updateStatus ?? this.updateStatus,
      getStatus: getStatus ?? this.getStatus,
      getAllStatus: getAllStatus ?? this.getAllStatus,
      serialSaveStatus: serialSaveStatus ?? this.serialSaveStatus,
      serialLoadStatus: serialLoadStatus ?? this.serialLoadStatus,
      deleteSerialStatus: deleteSerialStatus ?? this.deleteSerialStatus,
      serials: serials ?? this.serials,
      machine: machine ?? this.machine,
      machines: machines ?? this.machines,
      analysisStatus: analysisStatus ?? this.analysisStatus,
      analysis: analysis ?? this.analysis,
    );
  }
}
