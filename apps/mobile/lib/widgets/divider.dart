import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  final double width;
  final double height;

  const MyDivider({required this.height, required this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.white24.withAlpha(50),
    );
  }
}
