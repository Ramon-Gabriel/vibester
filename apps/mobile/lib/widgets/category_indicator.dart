import 'package:flutter/material.dart';
import 'package:mobile/utils/colors.dart';

class CategoryIndicator extends StatelessWidget {
  final String categoria;

  const CategoryIndicator({super.key, required this.categoria});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Color(colorAmbar).withAlpha(50),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(colorBrasa).withAlpha(150)),
      ),
      child: Text(
        categoria,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(colorBrasa),
          fontSize: 10,
        ),
      ),
    );
  }
}
