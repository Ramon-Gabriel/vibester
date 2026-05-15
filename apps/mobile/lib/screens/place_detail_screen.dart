import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/models/place_model.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/widgets/category_indicator.dart';
import 'package:mobile/widgets/divider.dart';
import 'package:mobile/widgets/place_stats_bar.dart';
import 'package:mobile/widgets/primary_button.dart';

class PlaceDetailScreen extends StatefulWidget {
  final PlaceModel place;

  const PlaceDetailScreen({super.key, required this.place});

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(colorNoturno),
      appBar: AppBar(
        title: Text(widget.place.nome),
        backgroundColor: Color(colorDarkGrey),
        foregroundColor: Colors.white,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
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
                const SizedBox(height: 60),

                Text(
                  widget.place.nome.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 10),

                CategoryIndicator(
                  categoria: widget.place.categoria.toUpperCase(),
                ),
                const SizedBox(height: 10),

                SizedBox(
                  width: 350,
                  child: Text(
                    widget.place.bio,
                    style: const TextStyle(color: Colors.white54),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),

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
                PlaceStatsBar(
                  seguidores: '12k',
                  avaliacao: widget.place.avaliacao,
                ),
                PrimaryButton(label: 'Seguir', onPressed: () {}),
                const SizedBox(height: 20),
              ],
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyTabBarDelegate(
              TabBar(
                controller: _tabController,
                unselectedLabelColor: Colors.white54,
                labelColor: Colors.white,
                dividerColor: Colors.transparent,
                indicatorColor: Color(colorAmbar),
                indicatorPadding: EdgeInsetsGeometry.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                labelPadding: EdgeInsets.all(10),
                labelStyle: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                tabs: [
                  Tab(text: 'DESTAQUES'),
                  Tab(text: 'EVENTOS'),
                  Tab(text: 'AVALIAÇÕES'),
                ],
              ),
              color: Color(colorNoturno),
            ),
          ),
        ],

        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.0),
              child: MyDivider(height: 1, width: double.infinity),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Center(child: Text('Destaques')),
                  Center(child: Text('Eventos')),
                  Center(child: Text('Avaliacoes')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final Color color;

  const _StickyTabBarDelegate(this.tabBar, {required this.color});

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: color, child: tabBar);
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) =>
      tabBar != oldDelegate.tabBar || color != oldDelegate.color;
}
