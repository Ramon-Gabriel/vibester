import 'package:flutter/material.dart';
import 'package:mobile/utils/colors.dart';

class MovimentoIndicator extends StatelessWidget {
  final int nivel;
  const MovimentoIndicator({super.key, required this.nivel});

  @override
  Widget build(BuildContext context) {
    Color _getColor(int nivel) {
      if (nivel <= 2) return Color(colorAmbar).withAlpha(200);
      if (nivel <= 3) return Color(colorAmbar).withAlpha(250);
      return Color(colorAmbar);
    }

    return Row(
      children: List.generate(5, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          width: 11,
          height: 16,
          decoration: BoxDecoration(
            color: index < nivel ? _getColor(nivel) : Colors.white24,
            borderRadius: BorderRadius.circular(2),
            border: BoxBorder.all(color: Color(colorAmbar), width: 1),
          ),
        );
      }),
    );
  }
}
