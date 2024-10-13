import 'dart:convert';
import 'package:chicnotes/models/user.dart';
import 'package:chicnotes/routes.dart';
import 'package:chicnotes/utils/baseurl.dart';
import 'package:chicnotes/utils/custom_snackbar.dart';
import 'package:chicnotes/utils/shared_prefs.dart';
import 'package:chicnotes/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  late TextEditingController emailController, passwordController;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  checkUser() async {
    var user = SharedPrefs().getUser();
    if (user != null) {
      Get.offAllNamed(GetRoutes.home);
    }
  }

  // @override
  // void onClose() {
  //   super.onClose();
  //   emailController.dispose();
  //   passwordController.dispose();
  // }

  checkLogin() {
    if (emailController.text.isEmpty ||
        GetUtils.isEmail(emailController.text) == false) {
      customSnackbar("Error", "A valid email is required", "error");
    } else if (passwordController.text.isEmpty) {
      customSnackbar("Error", "Password is required", "error");
    } else {
      Get.showOverlay(
          asyncFunction: () => login(), loadingWidget: const Loader());
    }
  }

  login() async {
    var response = await http.post(Uri.parse('${baseurl}login.php'), body: {
      "email": emailController.text,
      "password": passwordController.text,
    });

    var res = await json.decode(response.body);

    if (res['success']) {
      customSnackbar("Success", res['message'], "success");
      User user = User.fromJson(res['user']);
      await SharedPrefs().storeUser(json.encode(user));
      Get.offAllNamed(GetRoutes.home);
    } else {
      customSnackbar("Error", res['message'], "error");
    }
  }
}
