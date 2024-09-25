import 'package:flutter/material.dart';
import 'package:chicnotes/widgets/custom_textfield.dart'; 

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key}); // Menggunakan super.key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 120),
              // Wrap the Text widget
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
              const SizedBox(height: 50), // Menambah jarak antar widget
              const CustomTextField(
                hint: 'Email',
                obscureText: false, // Ensure this is set correctly
              ),
              const SizedBox(height: 10),
              const CustomTextField(
                hint: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xffff0000),
                  borderRadius: BorderRadius.circular(14.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0), // Padding for text
                  child: Text(
                    'Login', // Add text for the button
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    color: Color(0xff949494),
                  ),
                  children: [
                    TextSpan(
                      text: 'Don\'t have an account?'
                    ),
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 26, 255),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                textHeightBehavior: 
                  TextHeightBehavior(applyHeightToFirstAscent: false),
                  softWrap: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
