import 'package:flutter/material.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({super.key, required this.onChanged});

  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x29000000),
            offset: Offset(0, 3),
            blurRadius: 12,
          ),
        ],
      ),
      child: TextFormField(
        onChanged: (String val) {
          onChanged(val);
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Search Title",
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            color: Color(0xff949494),
          ),
        ),
      ),
    );
  }
}