import 'package:flutter/material.dart';
import 'package:mobile/models/event_model.dart';
import 'package:mobile/screens/event_detail_screen.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/widgets/event_card.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  final List<EventModel> event = [
    EventModel(
      dataDoEvento: DateTime(2026, 6, 10),
      titulo: "Noite do Sertanejo",
      artistas: "Maiara & Maraisa",
    ),

    EventModel(
      dataDoEvento: DateTime(2026, 7, 2),
      titulo: "Festival de Verão",
      artistas: "Alok",
    ),

    EventModel(
      dataDoEvento: DateTime(2026, 8, 15),
      titulo: "Rock in City",
      artistas: "Capital Inicial",
    ),

    EventModel(
      dataDoEvento: DateTime(2026, 9, 5),
      titulo: "Pagode na Praça",
      artistas: "Sorriso Maroto",
    ),

    EventModel(
      dataDoEvento: DateTime(2026, 10, 20),
      titulo: "Sunset Eletrônico",
      artistas: "Vintage Culture",
    ),

    EventModel(
      dataDoEvento: DateTime(2026, 11, 12),
      titulo: "Festival Universitário",
      artistas: "Jorge & Mateus",
    ),

    EventModel(
      dataDoEvento: DateTime(2026, 12, 31),
      titulo: "Réveillon Premium",
      artistas: "Anitta",
    ),

    EventModel(
      dataDoEvento: DateTime(2027, 1, 18),
      titulo: "Baile Funk Experience",
      artistas: "MC Ryan SP",
    ),

    EventModel(
      dataDoEvento: DateTime(2027, 2, 8),
      titulo: "Noite do Trap",
      artistas: "Matuê",
    ),

    EventModel(
      dataDoEvento: DateTime(2027, 3, 22),
      titulo: "Festival Pop Brasil",
      artistas: "Luísa Sonza",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(colorNoturno),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: event.length,
        itemBuilder: (context, index) {
          return EventCard(
            event: event[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EventDetailScreen(event: event[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
