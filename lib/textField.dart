import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    this.conf = "",
    this.a = 50,
    this.keyboard = TextInputType.text,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    required this.onChanged,
    required this.con,
    Key? key,
  }) : super(key: key);
  final String conf;
  final int a;
  final TextInputType keyboard;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final Function(String) onChanged;
  final TextEditingController con;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          right:25,
          left: 25,
          bottom: 15,),
      child: TextFormField(
        maxLength: a,
        keyboardType: keyboard,
        controller: con,
        obscureText: obscureText,
        style: const TextStyle(
          fontFamily: "SF",
          color: Color.fromARGB(255, 0, 0, 0),
          // fontWeight: FontWeight.w600,
          fontSize: 15.0,
        ),
        decoration: InputDecoration(
          counterText: "",
          contentPadding: const EdgeInsets.all(18.0),
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          prefixIcon: Icon(
            icon,
            size: 24.0,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: "SF",
            color: Color.fromARGB(255, 0, 0, 0),
            // fontWeight: FontWeight.w600,
            fontSize: 15.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: BorderSide(color: Colors.green.shade100),
          ),
          errorStyle: const TextStyle(fontFamily: "SF"),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: BorderSide(color: Colors.red.shade100),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: const BorderSide(color: Color.fromARGB(255, 215, 231, 216)),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}