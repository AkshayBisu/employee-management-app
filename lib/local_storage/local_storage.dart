import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

FlutterSecureStorage secureStorage = FlutterSecureStorage();

Future<void> clear() async {
  await secureStorage.deleteAll();
}

Future<void> save(String key, String value) async {
  await secureStorage.write(key: key, value: value);
}

Future<String> getValue(String key) async {
  return await secureStorage.read(key: key) ?? "";
}

Future saveAuthToken(token) async {
  return await save('AUTH_TOKEN', token);
}

Future getAuthToken() async {
  return await getValue('AUTH_TOKEN');
}

Future deleteAuthToken() async {
  await secureStorage.delete(key: 'AUTH_TOKEN');
}
