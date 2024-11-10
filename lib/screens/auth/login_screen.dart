import 'package:chicnotes/controllers/login_controller.dart';
import 'package:chicnotes/routes.dart';
import 'package:chicnotes/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:chicnotes/widgets/custom_textfield.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GetBuilder<LoginController>(builder: (controller) {
            return Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center, 
              children: [
                const SizedBox(height: 120),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'ChicNotes',
                    style: TextStyle(
                      fontSize: 54,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  hint: 'Email',
                  controller: controller.emailController,
                  obscureText: false,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  hint: 'Kata Sandi',
                  controller: controller.passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 40),
                CustomButton(
                  label: "Login",
                  onPressed: () {
                    controller.checkLogin();
                  },
                ),
                const SizedBox(height: 20),
                Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 17,
                      color: Color(0xff949494),
                    ),
                    children: [
                      const TextSpan(text: 'Belum punya akun? '),
                      TextSpan(
                        text: 'Sign Up',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(GetRoutes.signup);
                          },
                        style: const TextStyle(
                          color: Color.fromARGB(255, 0, 26, 255),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  textHeightBehavior:
                      const TextHeightBehavior(applyHeightToFirstAscent: false),
                  softWrap: false,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
