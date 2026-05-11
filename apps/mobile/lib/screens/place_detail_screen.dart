import 'package:flutter/material.dart';
import 'package:mobile/models/place_model.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/widgets/category_indicator.dart';
import 'package:mobile/widgets/place_stats_bar.dart';

class PlaceDetailScreen extends StatefulWidget {
  final PlaceModel place;

  const PlaceDetailScreen({super.key, required this.place});

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(colorNoturno),
      appBar: AppBar(
        title: Text(widget.place.nome),
        backgroundColor: Color(colorDarkGrey),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(height: 100, child: Placeholder()),
                Positioned(
                  bottom: -50,
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: ClipOval(child: Container(color: Colors.white)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
            Text(
              widget.place.nome.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            SizedBox(height: 10),
            CategoryIndicator(categoria: widget.place.categoria.toUpperCase()),
            SizedBox(height: 10),
            SizedBox(
              width: 350,
              child: Text(
                widget.place.bio,
                style: TextStyle(color: Colors.white54),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, color: Color(colorBrasa)),
                Text(
                  widget.place.endereco,
                  style: TextStyle(color: Colors.grey.withAlpha(90)),
                ),
              ],
            ),
            SizedBox(height: 10),
            PlaceStatsBar(seguidores: '12k', avaliacao: widget.place.avaliacao),
          ],
        ),
      ),
    );
  }
}
