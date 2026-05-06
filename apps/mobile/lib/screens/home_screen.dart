import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/screens/hot_places_screen.dart';
import 'package:mobile/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Color(colorDarkGrey),
        appBar: AppBar(
          toolbarHeight: 20,
          automaticallyImplyLeading: false,
          backgroundColor: Color(colorDarkGrey),
          foregroundColor: Color(colorAmbar),
          bottom: TabBar(
            unselectedLabelColor: Colors.white54,
            labelColor: Color(colorAmbar),
            dividerColor: Colors.transparent,
            indicatorColor: Color(colorAmbar),
            labelPadding: EdgeInsets.all(10),
            labelStyle: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            tabs: <Widget>[
              Tab(text: 'FEED'),
              Tab(text: 'DESTAQUES'),
              Tab(text: 'EM ALTA'),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            Center(child: Text("Feed")),
            Center(child: Text("Destaques")),
            HotPlacesScreen(),
          ],
        ),
      ),
    );
  }
}
