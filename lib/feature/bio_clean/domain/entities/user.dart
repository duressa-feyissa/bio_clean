import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;

  final String? token;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.token,
  });

  @override
  List<Object> get props => [
        id,
        firstName,
        lastName,
        phone,
        token ?? '',
      ];
}
