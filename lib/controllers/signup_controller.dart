import 'dart:convert';
import 'package:chicnotes/routes.dart';
import 'package:chicnotes/utils/baseurl.dart';
import 'package:chicnotes/utils/custom_snackbar.dart';
import 'package:chicnotes/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignupController extends GetxController {
  late TextEditingController nameController,
      emailController,
      passwordController,
      confirmPasswordController;

  @override
  void onInit() {
    super.onInit();

    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  checkSignup() {
    if (nameController.text.isEmpty) {
      customSnackbar("Error", "Name is required", "error");
    } else if (emailController.text.isEmpty ||
        GetUtils.isEmail(emailController.text) == false) {
      customSnackbar("Error", "A valid email is required", "error");
    } else if (passwordController.text.isEmpty) {
      customSnackbar("Error", "Password is required", "error");
    } else if (passwordController.text != confirmPasswordController.text) {
      customSnackbar("Error", "Password doesnot match!", "error");
    } else {
      Get.showOverlay(
          asyncFunction: () => signup(), loadingWidget: const Loader());
    }
  }

  signup() async {
    var response = await http.post(Uri.parse('${baseurl}signup.php'), body: {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
    });

    var res = await json.decode(response.body);

    if (res['success']) {
      customSnackbar("Success", res['message'], "success");
      Get.offAllNamed(GetRoutes.login);
    }else {
      customSnackbar("Error", res['message'], "error");
    }
  }
}
