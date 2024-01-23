import 'dart:convert';

import 'package:bio_clean/feature/bio_clean/data/model/input.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/errors/exception.dart';

abstract class InputLocalDataSource {
  Future<void> cacheMachine(List<InputModel> machinesToCache);
  Future<List<InputModel>> getInputs();
}

class InputLocalDataSourceImpl extends InputLocalDataSource {
  InputLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;
  static const String key = 'CACHED_INPUTS';

  @override
  Future<void> cacheMachine(List<InputModel> machinesToCache) async {
    final encodedData =
        machinesToCache.map((machine) => machine.toJson()).toList();
    final jsonString = json.encode(encodedData);

    await sharedPreferences.setString(key, jsonString);
  }

  @override
  Future<List<InputModel>> getInputs() async {
    final jsonString = sharedPreferences.getString(key);

    if (jsonString != null) {
      final List<dynamic> decodedData = json.decode(jsonString);
      final List<InputModel> cachedMachines = decodedData
          .map((machineData) => InputModel.fromJson(machineData))
          .toList();

      return cachedMachines;
    } else {
      throw CacheException();
    }
  }
}
