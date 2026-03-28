import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/screens/login_screen.dart';
import 'package:mobile/screens/register_screen.dart';
import 'package:mobile/utils/colors.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(colorNavy),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 250, child: Image.asset('assets/img/logo.png')),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text.rich(
                      TextSpan(
                        style: GoogleFonts.inter(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(text: 'Descubra os melhores '),
                          TextSpan(
                            text: 'rolês',
                            style: TextStyle(color: Color(colorAmbar)),
                          ),
                          TextSpan(text: ' da sua cidade'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Image.asset(
                    'assets/img/mascote.png',
                    width: 100,
                    height: 120,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Bares, baladas, restaurantes e eventos. Tudo em tempo real, perto de você.',
                style: GoogleFonts.inter(
                  color: Color(colorGrey),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(colorAmbar),
                    fixedSize: Size(300, 60),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text(
                    'COMEÇAR AGORA',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(colorNavy),
                  fixedSize: Size(300, 60),
                  side: BorderSide(color: Color(colorAmbar), width: 1),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: Text(
                  'JÁ TENHO UMA CONTA',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 150),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  children: [
                    TextSpan(text: 'Ao continuar, voce concorda com nossos '),
                    TextSpan(
                      text: 'Termos de Uso',
                      style: TextStyle(color: Color(colorAmbar)),
                    ),
                    TextSpan(text: ' e'),
                    TextSpan(
                      text: ' Politica de privacidade',
                      style: TextStyle(color: Color(colorAmbar)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
