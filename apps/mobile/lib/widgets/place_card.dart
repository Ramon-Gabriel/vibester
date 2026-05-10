import 'package:flutter/material.dart';
import 'package:mobile/models/place_model.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/widgets/category_indicator.dart';
import 'package:mobile/widgets/movement_indicator.dart';
import 'package:mobile/widgets/price_indicator.dart';

class PlaceCard extends StatelessWidget {
  final PlaceModel place;

  const PlaceCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(colorNoturno),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Color(colorGrey).withAlpha(80), width: 1),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(32),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(height: 70, width: 70, child: Placeholder()),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.nome,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 16),
                        SizedBox(width: 4),
                        Text(
                          '${place.avaliacao}',
                          style: TextStyle(color: Colors.white54),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.circle, color: Colors.white38, size: 6),
                        SizedBox(width: 4),
                        PriceIndicator(nivel: place.nivelPrecoMedio),
                      ],
                    ),
                    Text(
                      'Movimento',
                      style: TextStyle(
                        color: Colors.white.withAlpha(150),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    MovimentoIndicator(nivel: place.nivelMovimento),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: CategoryIndicator(categoria: place.categoria),
          ),
        ],
      ),
    );
  }
}
