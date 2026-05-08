import 'package:flutter/material.dart';

class MovimentoIndicator extends StatelessWidget {
  final int nivel;
  const MovimentoIndicator({super.key, required this.nivel});

  @override
  Widget build(BuildContext context) {
    Color _getColor(int nivel) {
      if (nivel <= 2) return Colors.red;
      if (nivel <= 3) return Colors.yellow;
      return Colors.green;
    }

    return Row(
      children: List.generate(5, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: 6,
          height: 16,
          decoration: BoxDecoration(
            color: index < nivel ? _getColor(nivel) : Colors.white24,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}
