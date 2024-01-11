import 'dart:convert';

import 'package:bio_clean/feature/bio_clean/data/model/machine.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/errors/exception.dart';

abstract class MachineRemoteDataSource {
  Future<List<MachineModel>> getMachines({
    required String userId,
    required String token,
  });

  Future<MachineModel> createMachine({
    required String name,
    required String serialNumber,
    required String location,
    required String userId,
    required String token,
  });
}

const String baseUrl = 'https://bioclean.onrender.com/api/v1';

class MachineRemoteDataSourceImpl implements MachineRemoteDataSource {
  const MachineRemoteDataSourceImpl({
    required this.client,
  });

  final http.Client client;

  @override
  Future<List<MachineModel>> getMachines({
    required String userId,
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/machines/$userId');

    final response = await client.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      final machines = jsonDecode(response.body);
      return machines.map((machine) => MachineModel.fromJson(machine)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MachineModel> createMachine(
      {required String name,
      required String serialNumber,
      required String location,
      required String userId,
      required String token}) async {
    final url = Uri.parse('$baseUrl/machines/$userId');

    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'name': name,
          'serialNumber': serialNumber,
          'location': location,
        },
      ),
    );

    if (response.statusCode == 200) {
      return MachineModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
