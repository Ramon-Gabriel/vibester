import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/utils/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(colorDarkGrey),
      body: Column(
        children: [
          Center(
            child: SizedBox(
              width: 130,
              height: 265,
              child: Image.asset('assets/img/mascote.png'),
            ),
          ),

          Text(
            'Criar conta',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Preencha seus dados para começar',
            style: GoogleFonts.inter(color: Color(colorGrey)),
          ),

          SizedBox(height: 15),

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 280, bottom: 10),
                child: Text(
                  'USUÁRIO',
                  style: GoogleFonts.inter(
                    color: Color(colorGrey),
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                height: 60,
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Color(colorAmbar),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF141414),
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(colorAmbar)),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório!';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 280, bottom: 10),
                child: Text(
                  'E-MAIL',
                  style: GoogleFonts.inter(
                    color: Color(colorGrey),
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                height: 60,
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Color(colorAmbar),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF141414),
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(colorAmbar)),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório!';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 290, bottom: 10),
                child: Text(
                  'SENHA',
                  style: GoogleFonts.inter(
                    color: Color(colorGrey),
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                height: 60,
                child: TextFormField(
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  cursorColor: Color(colorAmbar),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF141414),
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(colorAmbar)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório!';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: SizedBox(
                  width: 350,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(colorAmbar),
                    ),
                    child: Text(
                      'Entrar',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
