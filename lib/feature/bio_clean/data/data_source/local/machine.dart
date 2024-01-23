import 'dart:convert';

import 'package:bio_clean/feature/bio_clean/data/model/machine.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/errors/exception.dart';

abstract class MachineLocalDataSource {
  Future<List<MachineModel>> getMachine();
  Future<void> cacheMachine(List<MachineModel> machinesToCache);
  Future<MachineModel> deleteMachine(String id);
  Future<void> updateMachine(MachineModel machine);
  Future<void> deleteAllMachine();
  Future<MachineModel> findById(String id);

  Future<List<String>> loadIds();
  Future<void> saveMachine({required List<String> ids});
  Future<void> deleteSerial({required String id});
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
        machines.add(MachineModel.fromCache(element));
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
            MachineModel.fromCache(jsonMachine).id == machineToCache.id);

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

  @override
  Future<MachineModel> deleteMachine(String id) async {
    final jsonString = sharedPreferences.getString('CACHED_MACHINE');
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      final List<MachineModel> machines = [];
      dynamic removedMachine;
      for (var element in jsonList) {
        machines.add(MachineModel.fromCache(element));
      }

      List<MachineModel> newMachines = [];
      for (var element in machines) {
        if (element.id == id) {
          removedMachine = element;
        } else {
          newMachines.add(element);
        }
      }
      if (removedMachine != null) {
        await sharedPreferences.setString(
          'CACHED_MACHINE',
          json.encode(newMachines),
        );
        return removedMachine;
      } else {
        throw CacheException();
      }
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> updateMachine(MachineModel machine) async {
    final jsonString = sharedPreferences.getString('CACHED_MACHINE');
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      final List<MachineModel> machines = [];
      for (var element in jsonList) {
        machines.add(MachineModel.fromCache(element));
      }
      machines.removeWhere((element) => element.id == machine.id);
      machines.add(machine);
      await sharedPreferences.setString(
        'CACHED_MACHINE',
        json.encode(machines),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteAllMachine() async {
    await sharedPreferences.setString(
      'CACHED_MACHINE',
      json.encode([]),
    );
  }

  @override
  Future<MachineModel> findById(String id) async {
    final jsonString = sharedPreferences.getString('CACHED_MACHINE');
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      final List<MachineModel> machines = [];
      for (var element in jsonList) {
        machines.add(MachineModel.fromCache(json.decode(element)));
      }
      final machine =
          machines.firstWhere((element) => element.id == id, orElse: () {
        throw CacheException();
      });
      return machine;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> loadIds() async {
    final jsonString = sharedPreferences.getString('CACHED_IDS');
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      final List<String> ids = [];
      for (var element in jsonList) {
        ids.add(element);
      }
      return ids;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> saveMachine({required List<String> ids}) async {
    final jsonString = sharedPreferences.getString('CACHED_IDS');
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);

      for (var id in ids) {
        final existingIndex = jsonList.indexWhere((jsonId) => jsonId == id);

        if (existingIndex != -1) {
          jsonList[existingIndex] = id;
        } else {
          jsonList.add(id);
        }
      }
      await sharedPreferences.setString(
        'CACHED_IDS',
        json.encode(jsonList),
      );
    } else {
      await sharedPreferences.setString(
        'CACHED_IDS',
        json.encode(ids),
      );
    }
  }

  @override
  Future<void> deleteSerial({required String id}) async {
    var jsonString = sharedPreferences.getString('CACHED_IDS');
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      final List<String> ids = [];
      for (var element in jsonList) {
        ids.add(element);
      }
      ids.removeWhere((element) => element == id);

      jsonString = sharedPreferences.getString('CACHED_MACHINE');
      if (jsonString != null) {
        final List<dynamic> jsonList = json.decode(jsonString);
        final List<MachineModel> machines = [];
        dynamic removedMachine;
        for (var element in jsonList) {
          machines.add(MachineModel.fromCache(element));
        }

        List<MachineModel> newMachines = [];
        for (var element in machines) {
          if (element.serialNumber == id) {
            removedMachine = element;
          } else {
            newMachines.add(element);
          }
        }
        if (removedMachine != null) {
          await sharedPreferences.setString(
            'CACHED_MACHINE',
            json.encode(newMachines),
          );
          return removedMachine;
        } else {
          throw CacheException();
        }
      } else {
        throw CacheException();
      }
    } else {
      throw CacheException();
    }
  }
}
