import 'dart:convert';

import 'package:bio_clean/feature/bio_clean/data/model/machine.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/errors/exception.dart';

abstract class MachineLocalDataSource {
  Future<List<MachineModel>> getMachine();
  Future<void> cacheMachine(List<MachineModel> machinesToCache);
}

class MachineLocalDataSourceImpl implements MachineLocalDataSource {
  const MachineLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  @override
  Future<List<MachineModel>> getMachine() async {
    final jsonString = sharedPreferences.getString('CACHED_MACHINE');
    if (jsonString != null) {
      final List<MachineModel> machines = [];
      final List<dynamic> jsonList = json.decode(jsonString);
      for (var element in jsonList) {
        machines.add(MachineModel.fromJson(element));
      }
      return machines;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheMachine(List<MachineModel> machinesToCache) async {
    final jsonString = sharedPreferences.getString('CACHED_MACHINE');

    if (jsonString != null) {
      List<dynamic> jsonList = json.decode(jsonString);

      for (var machineToCache in machinesToCache) {
        final existingIndex = jsonList.indexWhere((jsonMachine) =>
            MachineModel.fromJson(jsonMachine).id == machineToCache.id);

        if (existingIndex != -1) {
          jsonList[existingIndex] = machineToCache.toJson();
        } else {
          jsonList.add(machineToCache.toJson());
        }
      }

      await sharedPreferences.setString(
        'CACHED_MACHINE',
        json.encode(jsonList),
      );
    } else {
      List<Map<String, dynamic>> machinesJsonList =
          machinesToCache.map((machine) => machine.toJson()).toList();

      await sharedPreferences.setString(
        'CACHED_MACHINE',
        json.encode(machinesJsonList),
      );
    }
  }
}
