part of 'user_bloc.dart';

enum UserStatus { initial, loading, success, failure }

enum LoginStatus { initial, loading, success, failure }

class UserState extends Equatable {
  final UserStatus status;
  final LoginStatus loginStatus;

  final User? user;

  const UserState(
      {this.status = UserStatus.initial,
      this.loginStatus = LoginStatus.initial,
      this.user});

  @override
  List<Object> get props => [
        status,
        loginStatus,
      ];

  UserState copyWith({
    UserStatus? status,
    LoginStatus? loginStatus,
    User? user,
  }) {
    return UserState(
      status: status ?? this.status,
      loginStatus: loginStatus ?? this.loginStatus,
      user: user ?? this.user,
    );
  }
}
