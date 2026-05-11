import 'package:flutter/material.dart';

class PlaceStatsBar extends StatelessWidget {
  final String seguidores;
  final double avaliacao;

  const PlaceStatsBar({
    super.key,
    required this.seguidores,
    required this.avaliacao,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StatItem(value: seguidores, label: 'SEGUIDORES'),
          _Divider(),
          _StatItem(
            value: avaliacao.toString(),
            label: 'AVALIAÇÕES',
            showStar: true,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final bool showStar;

  const _StatItem({
    required this.value,
    required this.label,
    this.showStar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (showStar) ...[
              const SizedBox(width: 4),
              const Icon(Icons.star, color: Colors.deepOrange, size: 18),
            ],
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 11,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 36, color: Colors.white24);
  }
}
