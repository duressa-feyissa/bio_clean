import 'dart:convert';

import 'package:bio_clean/feature/bio_clean/data/model/machine.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/errors/exception.dart';

abstract class MachineRemoteDataSource {
  Future<List<MachineModel>> getMachines({
    required String userId,
    required List<String> machinesId,
    required String token,
  });

  Future<MachineModel> createMachine({
    required String name,
    required String serialNumber,
    required String location,
    required String userId,
    required String token,
  });

  Future<MachineModel> updateMachine({
    required String id,
    required String name,
    required String serialNumber,
    required String location,
    required String token,
  });

  Future<MachineModel> deleteMachine({
    required String id,
    required String token,
  });

  Future<MachineModel> findById({
    required String id,
    required String token,
  });

  Future<String> analysis({
    required String id,
    required String token,
  });
}

const String baseUrl = 'https://bioclean.onrender.com/api/v1/machines';

class MachineRemoteDataSourceImpl implements MachineRemoteDataSource {
  const MachineRemoteDataSourceImpl({
    required this.client,
  });

  final http.Client client;

  @override
  Future<List<MachineModel>> getMachines({
    required String userId,
    required List<String> machinesId,
    required String token,
  }) async {
    final Map<String, dynamic> queryParameters = {
      'serialNumbers': machinesId.join(','),
    };

    final Uri url = Uri.parse('$baseUrl/$userId/views')
        .replace(queryParameters: queryParameters);

    final response = await client.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final machines = jsonDecode(response.body);

      final List<MachineModel> machineList = [];
      for (var element in machines) {
        machineList.add(MachineModel.fromJson(element));
      }

      return machineList;
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
    final url = Uri.parse('$baseUrl/$userId');

    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
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

  @override
  Future<MachineModel> updateMachine(
      {required String id,
      required String name,
      required String serialNumber,
      required String location,
      required String token}) async {
    final url = Uri.parse('$baseUrl/$id');

    final response = await client.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
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

  @override
  Future<MachineModel> deleteMachine(
      {required String id, required String token}) async {
    final url = Uri.parse('$baseUrl/$id/');

    final response = await client.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return MachineModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MachineModel> findById(
      {required String id, required String token}) async {
    final url = Uri.parse('$baseUrl/$id');

    final response = await client.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      return MachineModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> analysis({required String id, required String token}) async {
    final url = Uri.parse('$baseUrl/$id/analysis');

    final response = await client.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw ServerException();
    }
  }
}
