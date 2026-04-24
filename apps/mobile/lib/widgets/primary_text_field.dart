import 'package:flutter/material.dart';
import 'package:mobile/utils/colors.dart';

class PrimaryTextField extends StatelessWidget {
  final String labelText;
  final double height;

  const PrimaryTextField({
    super.key,
    required this.labelText,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: height,
      child: TextFormField(
        expands: true,
        maxLines: null,
        minLines: null,
        style: TextStyle(color: Colors.white),
        cursorColor: Color(colorAmbar),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white54),
          filled: true,
          fillColor: Color(0xFF141414),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Color(colorAmbar)),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo obrigatório!';
          }
          return null;
        },
      ),
    );
  }
}
