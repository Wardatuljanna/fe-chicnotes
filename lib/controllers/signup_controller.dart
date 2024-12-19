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

  checkSignup() {
    // Validasi semua kolom terisi
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      customSnackbar("Error", "All fields must be filled in", "error");
    } else if (!GetUtils.isEmail(emailController.text)) {
      customSnackbar("Error", "A valid email is required", "error");
    } else if (passwordController.text != confirmPasswordController.text) {
      customSnackbar("Error", "The password doesn't match!", "error");
    } else {
      Get.showOverlay(
          asyncFunction: () => signup(), loadingWidget: const Loader());
    }
  }

  signup() async {
    var response = await http.post(
      Uri.parse('${baseurl}auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
      }),
    );

    var res = json.decode(response.body);

    if (response.statusCode == 201 && res['message'] == 'User created successfully') {
      customSnackbar("Success", res['message'], "success");
      Get.offAllNamed(GetRoutes.login);
    } else if (response.statusCode == 409) {
      // Pesan error untuk email yang sudah digunakan
      customSnackbar("Error", "Email already in use. Use another email.", "error");
    } else {
      customSnackbar("Error", res['message'] ?? "Failed to register", "error");
    }
  }
}