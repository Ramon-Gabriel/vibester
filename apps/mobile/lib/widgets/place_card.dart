import 'package:flutter/material.dart';
import 'package:mobile/models/place_model.dart';
import 'package:mobile/utils/colors.dart';

class PlaceCard extends StatelessWidget {
  final PlaceModel place;

  const PlaceCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(colorDarkGrey),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              place.nome,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.category, color: Colors.white54, size: 16),
                const SizedBox(width: 4),
                Text(
                  place.categoria,
                  style: const TextStyle(color: Colors.white54),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.star, color: Color(colorAmbar), size: 16),
                const SizedBox(width: 4),
                Text(
                  '${place.avaliacao}',
                  style: const TextStyle(color: Colors.white54),
                ),
                const SizedBox(width: 16),
                Icon(Icons.people, color: Colors.white54, size: 16),
                const SizedBox(width: 4),
                Text(
                  'Movimento: ${place.nivelMovimento}',
                  style: const TextStyle(color: Colors.white54),
                ),
                const SizedBox(width: 16),
                Icon(Icons.attach_money, color: Colors.white54, size: 16),
                const SizedBox(width: 4),
                Text(
                  'Preço: ${place.nivelPrecoMedio}',
                  style: const TextStyle(color: Colors.white54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
