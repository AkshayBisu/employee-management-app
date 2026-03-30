import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:new_task/local_storage/local_storage.dart';

class StateController extends GetxController {
  final authToken = ''.obs;

  initAuth() async {
    final authTokenVal = await getAuthToken();
    authToken.value = authTokenVal;
  }

  setAuthToken(data) async {
    log('setAuthToken');
    log(jsonEncode(data));
    authToken.value = data;
    await saveAuthToken(data);
  }

  unsetAuth() async {
    authToken.value = '';
    await deleteAuthToken();
  }
}
