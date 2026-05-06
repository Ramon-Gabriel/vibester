import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/screens/home_screen.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/widgets/primary_button.dart';
import 'package:mobile/screens/recover_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(colorDarkGrey),
      body: Column(
        children: [
          Center(
            child: SizedBox(
              width: 130,
              height: 300,
              child: Image.asset('assets/img/mascote.png'),
            ),
          ),

          Text(
            'Entrar com e-mail',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Digite suas credenciais de acesso',
            style: GoogleFonts.inter(color: Color(colorGrey)),
          ),

          SizedBox(height: 30),

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 220, bottom: 10),
                child: Text(
                  'E-MAIL OU USUÁRIO',
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
                  child: PrimaryButton(
                    label: 'Entrar',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 90),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecoverPasswordScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Esqueci minha senha',
                    style: GoogleFonts.inter(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
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
