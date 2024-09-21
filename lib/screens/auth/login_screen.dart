import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key}); // Menggunakan super.key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'ChicNotes',
              style: TextStyle(
                fontSize: 54,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30), // Menambah jarak antar widget
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20), // Padding internal
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: const [ // BoxShadow perlu dimasukkan ke dalam list
                  BoxShadow(
                    color: Color(0x29000000),
                    offset: Offset(0, 3),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: TextFormField( 
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Email",
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    color: Color(0xff949494),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
