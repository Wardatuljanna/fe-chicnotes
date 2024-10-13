import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.label, required this.onPressed});

  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Center( // Wrap the button in a Center widget
      child: Container(
        width: double.infinity, // Match the button width with input fields
        padding: const EdgeInsets.symmetric(vertical: 10),
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
        child: InkWell( // Use InkWell for the button's onPressed
          onTap: () => onPressed(),
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Padding for text
            child: Text(
              label, // Display the passed label
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                color: Color(0xffffffff),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center, // Center the button text
            ),
          ),
        ),
      ),
    );
  }
}