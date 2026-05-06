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
      nome: 'Bar do Zé',
      nivelMovimento: 3,
      categoria: 'Bar',
      avaliacao: 4,
      nivelPrecoMedio: 2,
    ),
    PlaceModel(
      nome: 'Restaurante Sol',
      nivelMovimento: 2,
      categoria: 'Restaurante',
      avaliacao: 5,
      nivelPrecoMedio: 3,
    ),
    PlaceModel(
      nome: 'Café Central',
      nivelMovimento: 1,
      categoria: 'Café',
      avaliacao: 4,
      nivelPrecoMedio: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(colorDarkGrey),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) => PlaceCard(place: places[index]),
      ),
    );
  }
}
