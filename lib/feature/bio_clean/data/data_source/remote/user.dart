import 'dart:convert';

import 'package:bio_clean/core/errors/exception.dart';
import 'package:bio_clean/feature/bio_clean/data/model/user.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://bioclean.onrender.com/api/v1';

abstract class UserRemoteDataSource {
  Future<String> login(String phone, String password);
  Future<UserModel> getUser(String token);
  Future<UserModel> createUser({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  UserRemoteDataSourceImpl({
    required this.client,
  });

  final http.Client client;

  @override
  Future<UserModel> createUser({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/users');

    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'firstName': firstName,
          'lastName': lastName,
          'phone': phone,
          'password': password,
        },
      ),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getUser(String token) async {
    final url = Uri.parse('$baseUrl/users/me');

    final response = await client.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

   
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> login(String phone, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');

    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'phone': phone,
          'password': password,
        },
      ),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['token'];
    } else {
      throw ServerException();
    }
  }
}
