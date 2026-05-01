import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/screens/login_screen.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/widgets/primary_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(colorDarkGrey),
      body: Column(
        //Cabeçalho da pagina
        children: [
          Center(
            child: SizedBox(
              width: 130,
              height: 265,
              child: Image.asset('assets/img/mascote.png'),
            ),
          ),

          Text(
            'Recuperar Vibe',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Informe e confirme sua nova senha abaixo',
            style: GoogleFonts.inter(color: Color(colorGrey)),
          ),

          SizedBox(height: 15),

          //Nova senha a ser digitada
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

          SizedBox(height: 10),

          //Confirmação da nova senha digitada
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 230, bottom: 10),
                child: Text(
                  'CONFIRMA SENHA',
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


          // Botão que dispara a ação
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: SizedBox(
                  width: 350,
                  height: 50,
                  child: PrimaryButton(
                    label: 'Confirmar Senha',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
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