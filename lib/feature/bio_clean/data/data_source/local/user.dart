import 'dart:convert';

import 'package:bio_clean/core/errors/exception.dart';
import 'package:bio_clean/feature/bio_clean/data/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  Future<UserModel> getUser();
  Future<void> cacheUser(UserModel userToCache);
  Future<void> deleteUser();
}

const String cacheUserKey = 'CACHED_USER';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserModel userToCache) {
    return sharedPreferences.setString(
      cacheUserKey,
      json.encode(userToCache.toJson()),
    );
  }

  @override
  Future<UserModel> getUser() {
    final jsonString = sharedPreferences.getString(cacheUserKey);
    if (jsonString != null) {
      return Future.value(UserModel.fromCache(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteUser() {
    var jsonString = sharedPreferences.getString(cacheUserKey);
    if (jsonString != null) {
      sharedPreferences.remove(cacheUserKey);
    } else {
      throw CacheException();
    }

    jsonString = sharedPreferences.getString('CACHED_MACHINE');
    if (jsonString != null) {
      sharedPreferences.remove('CACHED_MACHINE');
    }

    jsonString = sharedPreferences.getString('CACHED_INPUTS');
    if (jsonString != null) {
      sharedPreferences.remove('CACHED_INPUTS');
    }

    jsonString = sharedPreferences.getString('CACHED_IDS');
    if (jsonString != null) {
      sharedPreferences.remove('CACHED_IDS');
    }

    return Future.value();
  }
}
