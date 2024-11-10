import 'package:chicnotes/controllers/signup_controller.dart';
import 'package:chicnotes/routes.dart';
import 'package:chicnotes/widgets/custom_button.dart';
import 'package:chicnotes/widgets/custom_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GetBuilder<SignupController>(builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
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
                const SizedBox(height: 30),
                CustomTextField(
                  hint: 'Nama',
                  controller: controller.nameController,
                ),
                const SizedBox(height: 15),
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
                const SizedBox(height: 15),
                CustomTextField(
                  hint: 'Konfirmasi Kata Sandi',
                  controller: controller.confirmPasswordController,  
                  obscureText: true,
                ),
                const SizedBox(height: 40),
                CustomButton(
                  label: "Sign Up",
                  onPressed: () {
                    controller.checkSignup();
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
                      const TextSpan(
                        text: 'Sudah punya akun? ',
                      ),
                      TextSpan(
                        text: 'Login',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(GetRoutes.login);
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
