import 'package:flutter/material.dart';
import 'package:mobile/models/place_model.dart';
import 'package:mobile/screens/place_detail_screen.dart';
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
      bio:
          'O point favorito dos trabalhadores do centro. Café coado na hora, wi-fi rápido e aquela energia de segunda de manhã o dia todo.',
      endereco: 'Av. Presidente Vargas, 142',
    ),
    PlaceModel(
      nome: 'Filin',
      nivelMovimento: 5,
      categoria: 'Balada',
      avaliacao: 4.9,
      nivelPrecoMedio: 'medio',
      bio:
          'A balada que não precisa de apresentação. Line-ups de peso, pista sempre lotada e som que você sente no peito.',
      endereco: 'R. das Palmeiras, 87',
    ),
    PlaceModel(
      nome: 'Churrasquero House',
      nivelMovimento: 4,
      categoria: 'Restaurante',
      avaliacao: 4.7,
      nivelPrecoMedio: 'baixo',
      bio:
          'Churrasco de verdade, sem frescura e sem preço salgado. Aqui a brasa nunca apaga e a fila anda rápido.',
      endereco: 'R. Tiradentes, 560',
    ),
    PlaceModel(
      nome: 'Porão Bar',
      nivelMovimento: 3,
      categoria: 'Bar',
      avaliacao: 4.2,
      nivelPrecoMedio: 'alto',
      bio:
          'Escondido no subsolo, o Porão tem drinques autorais, luz baixa e aquela vibe de quem sabe o que está fazendo.',
      endereco: 'R. Sete de Setembro, 34',
    ),
    PlaceModel(
      nome: 'Sushi Zen',
      nivelMovimento: 2,
      categoria: 'Japonês',
      avaliacao: 4.8,
      nivelPrecoMedio: 'alto',
      bio:
          'Experiência japonesa autêntica. Cada peça é montada com precisão e o ambiente convida ao silêncio e à boa comida.',
      endereco: 'Av. das Nações, 210',
    ),
    PlaceModel(
      nome: 'Pizza Roma',
      nivelMovimento: 4,
      categoria: 'Pizzaria',
      avaliacao: 4.3,
      nivelPrecoMedio: 'medio',
      bio:
          'Massa fina, forno a lenha e receitas que viajaram do interior da Itália até aqui. Simples assim, gostoso assim.',
      endereco: 'R. Floriano Peixoto, 415',
    ),
    PlaceModel(
      nome: 'Boteco do Léo',
      nivelMovimento: 5,
      categoria: 'Bar',
      avaliacao: 4.1,
      nivelPrecoMedio: 'baixo',
      bio:
          'O Léo conhece todo mundo pelo nome. Cerveja gelada, petisco farto e aquela conversa que se estende até depois da meia-noite.',
      endereco: 'R. das Acácias, 19',
    ),
    PlaceModel(
      nome: 'La Trattoria',
      nivelMovimento: 3,
      categoria: 'Italiano',
      avaliacao: 4.6,
      nivelPrecoMedio: 'alto',
      bio:
          'Massas frescas feitas no dia, carta de vinhos cuidadosa e um salão que faz qualquer jantar parecer especial.',
      endereco: 'Av. Brasil, 788',
    ),
    PlaceModel(
      nome: 'Hamburgueria 404',
      nivelMovimento: 4,
      categoria: 'Hamburgueria',
      avaliacao: 4.4,
      nivelPrecoMedio: 'medio',
      bio:
          'Referência não encontrada? Aqui não. Os hambúrgueres são artesanais, os combos são absurdos e o lugar é pequeno de propósito.',
      endereco: 'R. Marechal Deodoro, 301',
    ),
    PlaceModel(
      nome: 'Bistrô do Porto',
      nivelMovimento: 2,
      categoria: 'Bistrô',
      avaliacao: 4.5,
      nivelPrecoMedio: 'medio',
      bio:
          'Cardápio enxuto que muda com a estação. Ambiente aconchegante para quem quer comer bem sem pressa.',
      endereco: 'Av. Beira Rio, 55',
    ),
    PlaceModel(
      nome: 'Tapiocaria Sol',
      nivelMovimento: 3,
      categoria: 'Lanchonete',
      avaliacao: 4.0,
      nivelPrecoMedio: 'baixo',
      bio:
          'Tapiocas recheadas na hora, suco natural e aquele café da manhã que faz a diferença antes de encarar o dia.',
      endereco: 'R. Independência, 123',
    ),
    PlaceModel(
      nome: 'Churrascaria Gaúcha',
      nivelMovimento: 5,
      categoria: 'Churrascaria',
      avaliacao: 4.8,
      nivelPrecoMedio: 'alto',
      bio:
          'Rodízio completo com cortes nobres e gaúchos de verdade na churrasqueira. Venha com fome e saia feliz.',
      endereco: 'Av. Paraná, 940',
    ),
    PlaceModel(
      nome: 'Empório Vegano',
      nivelMovimento: 2,
      categoria: 'Vegano',
      avaliacao: 4.3,
      nivelPrecoMedio: 'alto',
      bio:
          'Culinária plant-based que convence até quem não é vegano. Ingredientes orgânicos, sabor sem concessão.',
      endereco: 'R. das Flores, 77',
    ),
    PlaceModel(
      nome: 'Bar da Esquina',
      nivelMovimento: 4,
      categoria: 'Bar',
      avaliacao: 3.9,
      nivelPrecoMedio: 'medio',
      bio:
          'Aquele bar de bairro que todo mundo tem saudade. Jogo na TV, mesa de plástico e doses generosas.',
      endereco: 'R. Almirante Barroso, 228',
    ),
    PlaceModel(
      nome: 'Doceria Mel',
      nivelMovimento: 1,
      categoria: 'Doceria',
      avaliacao: 4.7,
      nivelPrecoMedio: 'baixo',
      bio:
          'Doces artesanais feitos com amor e receitas de família. Um pedaço de bolo aqui vale mais que qualquer sobremesa chique.',
      endereco: 'R. Dom Pedro II, 11',
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
          return PlaceCard(
            place: places[index - 1],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PlaceDetailScreen(place: places[index - 1]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
