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
    checkUser();
  }

  checkUser() async {
    var user = await SharedPrefs().getUser();
    if (user != null) {
      Get.offAllNamed(GetRoutes.home);
    }
  }

  checkLogin() {
    if (emailController.text.isEmpty ||
        !GetUtils.isEmail(emailController.text)) {
      customSnackbar("Error", "A valid email is required", "error");
    } else if (passwordController.text.isEmpty) {
      customSnackbar("Error", "Password required", "error");
    } else {
      Get.showOverlay(
          asyncFunction: () => login(), loadingWidget: const Loader());
    }
  }
  
  login() async {
    try {
      var response = await http.post(
        Uri.parse('${baseurl}auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": emailController.text,
          "password": passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        var res = json.decode(response.body);

        // Cek apakah token ada
        if (res['token'] != null) {
          customSnackbar("Success", res['message'] ?? "Successful login", "success");
          
          // Simpan token
          await SharedPrefs().storeToken(res['token']); 

          // Simpan data user jika tersedia
          if (res['user'] != null) {
            User user = User.fromJson(res['user']);
            await SharedPrefs().storeUser(json.encode(user));
          }
          
          Get.offAllNamed(GetRoutes.home);
        } else {
          customSnackbar("Error", "Token not found.", "error");
        }
      } else if (response.statusCode == 401) {
        // Pesan error untuk password salah
        customSnackbar("Error", "The password you entered is incorrect.", "error");
      } else if (response.statusCode == 404) {
        // Pesan error untuk email tidak ditemukan
        customSnackbar("Error", "Email not found. Please check your email or register a new acc", "error");
      } else {
        customSnackbar("Error", "Login failed: ${response.statusCode}", "error");
      }
    } catch (e) {
      customSnackbar("Error", "An error occurred on the server: ${e.toString()}", "error");
    }
  }

  logout() async {
    await SharedPrefs().removeToken();
    await SharedPrefs().removeUser();
    Get.offAllNamed(GetRoutes.login);
  }
}