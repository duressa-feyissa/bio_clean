import 'package:bio_clean/feature/bio_clean/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String id,
    required String firstName,
    required String lastName,
    required String phone,
    String? token,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          token: token,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
      token: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'token': token,
    };
  }

  factory UserModel.fromCache(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
      token: json['token'],
    );
  }

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? phone,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      token: token ?? this.token,
    );
  }
}
