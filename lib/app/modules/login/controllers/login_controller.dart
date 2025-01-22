import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latihan_event/app/modules/dashboard/views/dashboard_view.dart';
import 'package:latihan_event/app/utils/api.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final _getConnect = GetConnect();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final authToken = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  final loginFormKey = GlobalKey<FormState>();

  void loginNow() async {
    if (!loginFormKey.currentState!.validate()) {
      Get.snackbar(
        'Validation Error',
        'Please check your input!',
        icon: const Icon(Icons.error),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final response = await _getConnect.post(BaseUrl.login,
        {'email': emailController.text, 'password': passwordController.text});

    if (response.statusCode == 200) {
      authToken.write('token', response.body['token']);
      Get.offAll(() => const DashboardView());
    } else {
      Get.snackbar(
        'Error',
        response.body['error'].toString(),
        icon: const Icon(Icons.error),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        forwardAnimationCurve: Curves.bounceIn,
        margin: const EdgeInsets.only(
          top: 10,
          left: 5,
          right: 5,
        ),
      );
    }
  }
}
