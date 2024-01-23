import 'package:bio_clean/feature/bio_clean/domain/entities/input.dart';
import 'package:bio_clean/feature/bio_clean/domain/use_cases/input/create.dart'
    as create;
import 'package:bio_clean/feature/bio_clean/domain/use_cases/input/delete.dart'
    as delete;
import 'package:bio_clean/feature/bio_clean/domain/use_cases/input/update.dart'
    as update;
import 'package:bio_clean/feature/bio_clean/domain/use_cases/input/view.dart'
    as view;
import 'package:bio_clean/feature/bio_clean/domain/use_cases/input/viiews.dart'
    as views;
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

part 'input_event.dart';
part 'input_state.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

const throttleDuration = Duration(milliseconds: 100);

class InputBloc extends Bloc<InputEvent, InputState> {
  final view.ViewInput getInput;
  final views.ViewInputs getInputs;
  final create.CreateInput createInput;
  final delete.DeleteInput deleteInput;
  final update.UpdateInput updateInput;

  InputBloc({
    required this.getInput,
    required this.getInputs,
    required this.createInput,
    required this.deleteInput,
    required this.updateInput,
  }) : super(const InputState()) {
    on<InputViewEvent>(_onInputGetEvent,
        transformer: throttleDroppable(throttleDuration));
    on<InputViewAllEvent>(_onInputGetsEvent,
        transformer: throttleDroppable(throttleDuration));
    on<InputCreateEvent>(_onInputCreateEvent,
        transformer: throttleDroppable(throttleDuration));
    on<InputDeleteEvent>(_onInputDeleteEvent,
        transformer: throttleDroppable(throttleDuration));
    on<InputUpdateEvent>(_onInputUpdateEvent,
        transformer: throttleDroppable(throttleDuration));
  }

  Future<void> _onInputGetEvent(
      InputViewEvent event, Emitter<InputState> emit) async {
    emit(state.copyWith(getStatus: InputGetStatus.loading));
    final result = await getInput(view.Params(
      id: event.id,
      token: event.token,
    ));

    emit(result.fold(
        (failure) => state.copyWith(getStatus: InputGetStatus.failure), (data) {
      List<Input> inputs = [];
      for (var input in state.inputs) {
        if (input.id == data.id) {
          inputs.add(data);
        } else {
          inputs.add(input);
        }
      }
      return state.copyWith(
        getStatus: InputGetStatus.success,
        input: data,
        inputs: inputs,
      );
    }));
  }

  Future<void> _onInputGetsEvent(
      InputViewAllEvent event, Emitter<InputState> emit) async {
    emit(state.copyWith(getStatus: InputGetStatus.loading));
    final result = await getInputs(views.Params(
      id: event.machineId,
      token: event.token,
    ));

    emit(result.fold(
      (failure) => state.copyWith(getStatus: InputGetStatus.failure),
      (data) => InputState(
        getAllStatus: InputGetAllStatus.success,
        inputs: data,
      ),
    ));
  }

  Future<void> _onInputCreateEvent(
      InputCreateEvent event, Emitter<InputState> emit) async {
    emit(state.copyWith(createStatus: InputCreateStatus.loading));
    final result = await createInput(create.Params(
      machineId: event.machineId,
      type: event.type,
      water: event.water,
      waste: event.waste,
      methanol: event.methanol,
      token: event.token,
    ));

    emit(
      result.fold(
        (failure) => state.copyWith(createStatus: InputCreateStatus.failure),
        (data) => state.copyWith(
          createStatus: InputCreateStatus.success,
          inputs: [data, ...state.inputs],
          input: data,
        ),
      ),
    );
  }

  Future<void> _onInputDeleteEvent(
      InputDeleteEvent event, Emitter<InputState> emit) async {
    emit(state.copyWith(deleteStatus: InputDeleteStatus.loading));
    final result = await deleteInput(delete.Params(
      id: event.id,
      token: event.token,
    ));

    emit(result.fold(
      (failure) => state.copyWith(deleteStatus: InputDeleteStatus.failure),
      (data) {
        final inputs = state.inputs.where((element) => element.id != event.id);

        return state.copyWith(
          deleteStatus: InputDeleteStatus.success,
          inputs: inputs.toList(),
        );
      },
    ));
  }

  Future<void> _onInputUpdateEvent(
      InputUpdateEvent event, Emitter<InputState> emit) async {
    emit(state.copyWith(updateStatus: InputUpdateStatus.loading));
    final result = await updateInput(update.Params(
      id: event.id,
      type: event.type,
      water: event.water,
      waste: event.waste,
      methanol: event.methanol,
      token: event.token,
    ));

    emit(result.fold(
      (failure) => state.copyWith(updateStatus: InputUpdateStatus.failure),
      (data) {
        final inputs = state.inputs.map((input) {
          if (input.id == event.id) {
            return data;
          }
          return input;
        }).toList();

        return state.copyWith(
          updateStatus: InputUpdateStatus.success,
          inputs: inputs,
          input: data,
        );
      },
    ));
  }
}
