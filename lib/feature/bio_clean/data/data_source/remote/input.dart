import 'dart:convert';

import 'package:bio_clean/core/errors/exception.dart';
import 'package:bio_clean/feature/bio_clean/data/model/input.dart';
import 'package:http/http.dart' as http;

abstract class InputRemoteDataSource {
  Future<InputModel> getInput({
    required String id,
    required String token,
  });
  Future<List<InputModel>> getInputs({
    required String id,
    required String token,
  });
  Future<InputModel> delete({
    required String id,
    required String token,
  });
  Future<InputModel> create({
    required String machineId,
    required String type,
    required double water,
    required double waste,
    required double methanol,
    required String token,
  });
  Future<InputModel> update({
    required String id,
    required String type,
    required double water,
    required double waste,
    required double methanol,
    required String token,
  });
}

const String baseUrl = 'https://bioclean.onrender.com/api/v1/inputs';

class InputRemoteDataSourceImpl extends InputRemoteDataSource {
  InputRemoteDataSourceImpl({
    required this.client,
  });

  final http.Client client;

  @override
  Future<InputModel> create({
    required String machineId,
    required String type,
    required double water,
    required double waste,
    required double methanol,
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/$machineId');

    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
        {'type': type, 'water': water, 'waste': waste, 'methanol': methanol},
      ),
    );

    if (response.statusCode == 200) {
      return InputModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<InputModel> delete({required String id, required String token}) async {
    final url = Uri.parse('$baseUrl/$id');

    final response = await client.delete(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      return InputModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<InputModel> getInput(
      {required String id, required String token}) async {
    final url = Uri.parse('$baseUrl/$id');

    final response = await client.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      return InputModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<InputModel>> getInputs(
      {required String id, required String token}) async {
    final url = Uri.parse('$baseUrl/$id/views');

    final response = await client.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      final inputs = jsonDecode(response.body);

      final List<InputModel> inputList = [];
      for (var element in inputs) {
        inputList.add(InputModel.fromJson(element));
      }

      return inputList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<InputModel> update({
    required String id,
    required String type,
    required double water,
    required double waste,
    required double methanol,
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/$id');

    final response = await client.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
        {'type': type, 'water': water, 'waste': waste, 'methanol': methanol},
      ),
    );

    if (response.statusCode == 200) {
      return InputModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
