import 'package:bio_clean/core/use_cases/usecase.dart';
import 'package:bio_clean/feature/bio_clean/domain/use_cases/machine/analysis.dart'
    as analysis;
import 'package:bio_clean/feature/bio_clean/domain/use_cases/machine/create.dart'
    as create;
import 'package:bio_clean/feature/bio_clean/domain/use_cases/machine/delete.dart'
    as delete;
import 'package:bio_clean/feature/bio_clean/domain/use_cases/machine/load.dart'
    as load;
import 'package:bio_clean/feature/bio_clean/domain/use_cases/machine/save.dart'
    as save;
import 'package:bio_clean/feature/bio_clean/domain/use_cases/machine/serial_delete.dart'
    as serial_delete;
import 'package:bio_clean/feature/bio_clean/domain/use_cases/machine/update.dart'
    as update;
import 'package:bio_clean/feature/bio_clean/domain/use_cases/machine/view.dart'
    as view;
import 'package:bio_clean/feature/bio_clean/domain/use_cases/machine/views.dart'
    as views;
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../domain/entities/machine.dart';

part 'machine_event.dart';
part 'machine_state.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

const throttleDuration = Duration(milliseconds: 100);

class MachineBloc extends Bloc<MachineEvent, MachineState> {
  final view.GetMachine getMachine;
  final views.GetMachines getMachines;
  final create.CreateMachine createMachine;
  final delete.DeleteMachine deleteMachine;
  final update.UpdateMachine updateMachine;
  final load.LoadMachine loadMachine;
  final save.SaveMachine saveMachine;
  final serial_delete.DeleteBySerial deleteBySerial;
  final analysis.AnalysisMachine analysisMachine;

  MachineBloc({
    required this.getMachine,
    required this.getMachines,
    required this.createMachine,
    required this.deleteMachine,
    required this.updateMachine,
    required this.loadMachine,
    required this.saveMachine,
    required this.deleteBySerial,
    required this.analysisMachine,
  }) : super(const MachineState()) {
    on<MachineGetEvenet>(_onMachineGetEvent,
        transformer: throttleDroppable(throttleDuration));
    on<MachineGetAllEvent>(_onMachineGetsEvent,
        transformer: throttleDroppable(throttleDuration));
    on<MachineCreateEvent>(_onMachineCreateEvent,
        transformer: throttleDroppable(throttleDuration));
    on<MachineDeleteEvent>(_onMachineDeleteEvent,
        transformer: throttleDroppable(throttleDuration));
    on<MachineUpdateEvent>(_onMachineUpdateEvent,
        transformer: throttleDroppable(throttleDuration));
    on<LoadMachinesSerialEvent>(_onMachineLoadEvent,
        transformer: throttleDroppable(throttleDuration));
    on<SaveMachinesSerialEvent>(_onMachineSaveEvent,
        transformer: throttleDroppable(throttleDuration));
    on<DeleteMachineSerialEvent>(_onMachineDeleteSerialEvent,
        transformer: throttleDroppable(throttleDuration));
    on<ClearMachine>(_onClearMachineEvent,
        transformer: throttleDroppable(throttleDuration));
    on<AnalysisMachineSerialEvent>(_onMachineAnalysisEvent,
        transformer: throttleDroppable(throttleDuration));
  }

  Future<void> _onMachineGetEvent(
      MachineGetEvenet event, Emitter<MachineState> emit) async {
    emit(state.copyWith(getStatus: MachineGetStatus.loading));
    final result = await getMachine(view.Params(
      id: event.id,
      token: event.token,
    ));

    emit(result.fold(
      (failure) => state.copyWith(getStatus: MachineGetStatus.failure),
      (data) => state.copyWith(
        getStatus: MachineGetStatus.success,
        machine: data,
      ),
    ));
  }

  Future<void> _onMachineGetsEvent(
      MachineGetAllEvent event, Emitter<MachineState> emit) async {
    emit(state.copyWith(getAllStatus: MachineGetAllStatus.loading));
    final result = await getMachines(views.Params(
      token: event.token,
      machinesId: event.machinesId,
      userId: event.userId,
    ));

    emit(result.fold(
      (failure) => state.copyWith(getAllStatus: MachineGetAllStatus.failure),
      (data) {
        final Set<Machine> machines = {...state.machines};
        machines.addAll(data);

        return state.copyWith(
          getAllStatus: MachineGetAllStatus.success,
          machines: machines.toList(),
        );
      },
    ));
  }

  Future<void> _onMachineCreateEvent(
      MachineCreateEvent event, Emitter<MachineState> emit) async {
    emit(state.copyWith(createStatus: MachineCreateStatus.loading));
    final result = await createMachine(create.Params(
      name: event.name,
      userId: event.userId,
      serialNumber: event.serialNumber,
      location: event.location,
      token: event.token,
    ));

    emit(result.fold(
        (failure) => state.copyWith(createStatus: MachineCreateStatus.failure),
        (data) {
      final machines = [...state.machines, data];

      return state.copyWith(
        createStatus: MachineCreateStatus.success,
        machines: machines,
        machine: data,
      );
    }));
  }

  Future<void> _onMachineDeleteEvent(
      MachineDeleteEvent event, Emitter<MachineState> emit) async {
    emit(state.copyWith(deleteStatus: MachineDeleteStatus.loading));

    final result = await deleteMachine(delete.Params(
      id: event.id,
      token: event.token,
    ));

    emit(result.fold(
      (failure) => state.copyWith(deleteStatus: MachineDeleteStatus.failure),
      (data) {
        final updatedMachines =
            state.machines.where((machine) => machine.id != event.id).toList();

        return state.copyWith(
          deleteStatus: MachineDeleteStatus.success,
          machines: updatedMachines,
          machine: data,
        );
      },
    ));
  }

  Future<void> _onMachineUpdateEvent(
      MachineUpdateEvent event, Emitter<MachineState> emit) async {
    emit(state.copyWith(updateStatus: MachineUpdateStatus.loading));
    final result = await updateMachine(update.Params(
      id: event.id,
      name: event.name,
      serialNumber: event.serialNumber,
      location: event.location,
      token: event.token,
    ));

    emit(result.fold(
        (failure) => state.copyWith(updateStatus: MachineUpdateStatus.failure),
        (data) {
      final updatedMachines = state.machines
          .map((machine) => machine.id == event.id ? data : machine)
          .toList();

      return state.copyWith(
        updateStatus: MachineUpdateStatus.success,
        machines: updatedMachines,
        machine: data,
      );
    }));
  }

  Future<void> _onMachineLoadEvent(
      LoadMachinesSerialEvent event, Emitter<MachineState> emit) async {
    emit(state.copyWith(serialLoadStatus: MachineSerialLoadStatus.loading));
    final result = await loadMachine(NoParams());

    emit(result.fold(
        (failure) =>
            state.copyWith(serialLoadStatus: MachineSerialLoadStatus.failure),
        (data) {
      return state.copyWith(
        serialLoadStatus: MachineSerialLoadStatus.success,
        serials: data,
      );
    }));
  }

  Future<void> _onMachineSaveEvent(
      SaveMachinesSerialEvent event, Emitter<MachineState> emit) async {
    emit(state.copyWith(serialSaveStatus: MachineSerialSaveStatus.loading));
    final result = await saveMachine(save.Params(ids: event.ids));

    emit(result.fold(
        (failure) =>
            state.copyWith(serialSaveStatus: MachineSerialSaveStatus.failure),
        (data) {
      return state.copyWith(
          serialSaveStatus: MachineSerialSaveStatus.success,
          serials: [...state.serials, ...event.ids]);
    }));
  }

  Future<void> _onMachineDeleteSerialEvent(
      DeleteMachineSerialEvent event, Emitter<MachineState> emit) async {
    emit(state.copyWith(deleteSerialStatus: MachineDeleteSerialStatus.loading));
    final result = await deleteBySerial(serial_delete.Params(id: event.id));

    emit(result.fold(
        (failure) => state.copyWith(
            deleteSerialStatus: MachineDeleteSerialStatus.failure), (data) {
      final machines = state.machines
          .where((machine) => machine.serialNumber != event.id)
          .toList();

      return state.copyWith(
        deleteSerialStatus: MachineDeleteSerialStatus.success,
        machines: machines,
      );
    }));
  }

  Future<void> _onClearMachineEvent(
      ClearMachine event, Emitter<MachineState> emit) {
    emit(const MachineState());
    return Future.value();
  }

  Future<void> _onMachineAnalysisEvent(
      AnalysisMachineSerialEvent event, Emitter<MachineState> emit) async {
    emit(state.copyWith(analysisStatus: MachineAnalysisStatus.loading));
    final result = await analysisMachine(analysis.Params(
      id: event.id,
      token: event.token,
    ));

    emit(result.fold(
      (failure) =>
          state.copyWith(analysisStatus: MachineAnalysisStatus.failure),
      (data) => state.copyWith(
        analysisStatus: MachineAnalysisStatus.success,
        analysis: data,
      ),
    ));
  }
}
