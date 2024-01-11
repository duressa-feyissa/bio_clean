part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

final class CreateUserEvent extends UserEvent {
  final String firstName;
  final String lastName;
  final String phone;
  final String password;

  const CreateUserEvent({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.password,
  });

  @override
  List<Object> get props => [firstName, lastName, phone, password];
}

final class LoginUserEvent extends UserEvent {
  final String phone;
  final String password;

  const LoginUserEvent({
    required this.phone,
    required this.password,
  });

  @override
  List<Object> get props => [phone, password];
}


final class LogoutUserEvent extends UserEvent {
  const LogoutUserEvent();
}

final class GetUserEvent extends UserEvent {
  const GetUserEvent();
}

final class UpdateUserEvent extends UserEvent {
  final String firstName;
  final String lastName;
  final String phone;
  final String password;

  const UpdateUserEvent({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.password,
  });

  @override
  List<Object> get props => [firstName, lastName, phone, password];
}
