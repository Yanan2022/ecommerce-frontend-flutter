import 'dart:convert';
// import 'dart:js';

import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:frontend/model/user.dart';
import 'package:frontend/service/local_service/local_auth_service.dart';
import 'package:frontend/service/remote_service/remote_auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  Rxn<User> user = Rxn<User>();
  final LocalAuthService _localAuthService = LocalAuthService();

  @override
  void onInit() async {
    await _localAuthService.init();
    super.onInit();
  }

  void signUp(
      {required String fullName,
      required String email,
      required String password}) async {
    try {
      EasyLoading.show(
        status: 'Loading...',
        dismissOnTap: false,
      );
      var result = await RemoteAuthService().signUp(
        email: email,
        password: password,
      );
      if (result.statusCode == 200) {
        String token = json.decode(result.body)['jwt'];
        var userResult = await RemoteAuthService()
            .createProfile(fullName: fullName, token: token);
        if (userResult.statusCode == 200) {
          user.value = userFromJson(userResult.body);
          await _localAuthService.addToken(token: token);
          await _localAuthService.addUser(user: user.value!);
          EasyLoading.showSuccess("Bienvenu à Toure!");
          Navigator.of(Get.overlayContext!).pop();
        } else {
          EasyLoading.showError(
              'Quelque chose s est mal passé. Essayer encore!');
        }
      } else {
        EasyLoading.showError('Quelque chose s est mal passé. Essayer encore!');
      }
    } catch (e) {
      EasyLoading.showError('Quelque chose s est mal passé. Essayer encore!');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void signIn({required String email, required String password}) async {
    try {
      EasyLoading.show(
        status: 'Loading...',
        dismissOnTap: false,
      );
      var result =
          await RemoteAuthService().signIn(email: email, password: password);
      if (result.statusCode == 200) {
        String token = json.decode(result.body)['jwt'];
        var userResult = await RemoteAuthService().getProfile(token: token);
        if (userResult.statusCode == 200) {
          user.value = userFromJson(userResult.body);
          await _localAuthService.addToken(token: token);
          await _localAuthService.addUser(user: user.value!);
          EasyLoading.showSuccess("Bienvenu à Toure!");
          Navigator.of(Get.overlayContext!).pop();
        } else {
          EasyLoading.showError('Ici 3');
        }
      } else {
        EasyLoading.showError('Ici 2!');
      }
    } catch (e) {
      debugPrint(e.toString());
      EasyLoading.showError('Ici 1');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void signOut() async {
    user.value = null;
    await _localAuthService.clear();
  }
}
