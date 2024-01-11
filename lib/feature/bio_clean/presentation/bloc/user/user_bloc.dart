import 'package:bio_clean/core/use_cases/usecase.dart';
import 'package:bio_clean/feature/bio_clean/domain/use_cases/user/create.dart'
    as user_create;
import 'package:bio_clean/feature/bio_clean/domain/use_cases/user/login.dart'
    as user_login;
import 'package:bio_clean/feature/bio_clean/domain/use_cases/user/view.dart'
    as user_view;
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../domain/entities/user.dart';

part 'user_event.dart';
part 'user_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class UserBloc extends Bloc<UserEvent, UserState> {
  final user_create.CreateUser userCreate;
  final user_login.UserLogin userLogin;
  final user_view.GetUser userGet;

  UserBloc(
      {required this.userCreate,
      required this.userLogin,
      required this.userGet})
      : super(const UserState()) {
    on<CreateUserEvent>(_onUserCreateEvent,
        transformer: throttleDroppable(throttleDuration));
    on<LoginUserEvent>(_onUserLoginEvent,
        transformer: throttleDroppable(throttleDuration));
    on<GetUserEvent>(_onUserGetEvent,
        transformer: throttleDroppable(throttleDuration));
  }

  Future<void> _onUserCreateEvent(
      CreateUserEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    final result = await userCreate.call(user_create.Params(
      firstName: event.firstName,
      lastName: event.lastName,
      phone: event.phone,
      password: event.password,
    ));
    result.fold(
      (failure) => emit(state.copyWith(status: UserStatus.failure)),
      (user) => emit(state.copyWith(status: UserStatus.success, user: user)),
    );
  }

  Future<void> _onUserLoginEvent(
      LoginUserEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.loading));

    final result = await userLogin.call(user_login.Params(
      phone: event.phone,
      password: event.password,
    ));

    result.fold((failure) => emit(state.copyWith(status: UserStatus.failure)),
        (user) {
      emit(state.copyWith(status: UserStatus.success, user: user));
      print(state.user);
    });
  }

  Future<void> _onUserGetEvent(
      GetUserEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    final result = await userGet.call(NoParams());

    result.fold((failure) {
      emit(state.copyWith(status: UserStatus.failure));
    }, (user) {
      emit(state.copyWith(status: UserStatus.success, user: user));
    });
  }
}
