import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppSecureStorage {
  FlutterSecureStorage _secureStorage;
  JsonRepo _jsonRepo;
  AppSecureStorage(JsonRepo jsonRepo) {
    this._secureStorage = new FlutterSecureStorage();
    this._jsonRepo = jsonRepo;
  }
  Future<void> deleteAllAsync() async {
    await _secureStorage.deleteAll();
  }

  Future<void> deleteAsync({String key}) async {
    await _secureStorage.delete(key: key);
  }

  Future<String> readStringAsync({String key}) async {
    var value = await _secureStorage.read(key: key);
    return value;
  }

  Future<T> readAsync<T>(String key) async {
    String data = null;
    try {
      data = await _secureStorage.read(key: key);
    } catch (exception) {
      print(exception);
    }
    if (data == null) return null;
    dynamic obj = this._jsonRepo.decode(data);
    return this._jsonRepo.from<T>(obj);
  }

  Future<void> writeAsync({String key, dynamic value}) async {
    String data;
    try {
      data = this._jsonRepo.encode(value);
    } catch (ex) {
      print(ex);
    }
    await _secureStorage.write(key: key, value: data);
  }

  Future<void> writeStringAsync({String key, String value}) async {
    await _secureStorage.write(key: key, value: value);
  }
}
