import 'package:flutter/material.dart';
import 'package:mobile/models/place_model.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/widgets/place_card.dart';

class HotPlacesScreen extends StatefulWidget {
  const HotPlacesScreen({super.key});

  @override
  State<HotPlacesScreen> createState() => _HotPlacesScreenState();
}

class _HotPlacesScreenState extends State<HotPlacesScreen> {
  final List<PlaceModel> places = [
    PlaceModel(
      nome: 'Café Central',
      nivelMovimento: 5,
      categoria: 'Café',
      avaliacao: 4.0,
      nivelPrecoMedio: 'alto',
    ),
    PlaceModel(
      nome: 'Filin',
      nivelMovimento: 5,
      categoria: 'Balada',
      avaliacao: 4.9,
      nivelPrecoMedio: 'medio',
    ),
    PlaceModel(
      nome: 'Churrasquero House',
      nivelMovimento: 4,
      categoria: 'Restaurante',
      avaliacao: 4.7,
      nivelPrecoMedio: 'baixo',
    ),
    PlaceModel(
      nome: 'Porão Bar',
      nivelMovimento: 3,
      categoria: 'Bar',
      avaliacao: 4.2,
      nivelPrecoMedio: 'alto',
    ),
    PlaceModel(
      nome: 'Sushi Zen',
      nivelMovimento: 2,
      categoria: 'Japonês',
      avaliacao: 4.8,
      nivelPrecoMedio: 'alto',
    ),
    PlaceModel(
      nome: 'Pizza Roma',
      nivelMovimento: 4,
      categoria: 'Pizzaria',
      avaliacao: 4.3,
      nivelPrecoMedio: 'medio',
    ),
    PlaceModel(
      nome: 'Boteco do Léo',
      nivelMovimento: 5,
      categoria: 'Bar',
      avaliacao: 4.1,
      nivelPrecoMedio: 'baixo',
    ),
    PlaceModel(
      nome: 'La Trattoria',
      nivelMovimento: 3,
      categoria: 'Italiano',
      avaliacao: 4.6,
      nivelPrecoMedio: 'alto',
    ),
    PlaceModel(
      nome: 'Hamburgueria 404',
      nivelMovimento: 4,
      categoria: 'Hamburgueria',
      avaliacao: 4.4,
      nivelPrecoMedio: 'medio',
    ),
    PlaceModel(
      nome: 'Bistrô do Porto',
      nivelMovimento: 2,
      categoria: 'Bistrô',
      avaliacao: 4.5,
      nivelPrecoMedio: 'medio',
    ),
    PlaceModel(
      nome: 'Tapiocaria Sol',
      nivelMovimento: 3,
      categoria: 'Lanchonete',
      avaliacao: 4.0,
      nivelPrecoMedio: 'baixo',
    ),
    PlaceModel(
      nome: 'Churrascaria Gaúcha',
      nivelMovimento: 5,
      categoria: 'Churrascaria',
      avaliacao: 4.8,
      nivelPrecoMedio: 'alto',
    ),
    PlaceModel(
      nome: 'Empório Vegano',
      nivelMovimento: 2,
      categoria: 'Vegano',
      avaliacao: 4.3,
      nivelPrecoMedio: 'alto',
    ),
    PlaceModel(
      nome: 'Bar da Esquina',
      nivelMovimento: 4,
      categoria: 'Bar',
      avaliacao: 3.9,
      nivelPrecoMedio: 'medio',
    ),
    PlaceModel(
      nome: 'Doceria Mel',
      nivelMovimento: 1,
      categoria: 'Doceria',
      avaliacao: 4.7,
      nivelPrecoMedio: 'baixo',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(colorNoturno),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: places.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Populares Agora',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text.rich(
                    TextSpan(
                      text: 'Os locais mais movimentados da cidade ',
                      style: TextStyle(color: Colors.white54, fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'ao vivo!',
                          style: TextStyle(
                            color: Color(colorAmbar),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return PlaceCard(place: places[index - 1]); // -1 por causa do header
        },
      ),
    );
  }
}
