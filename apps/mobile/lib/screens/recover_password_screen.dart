import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/screens/email_confirm_screen.dart';
import 'package:mobile/screens/reset_password_screen.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/widgets/primary_button.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({super.key});

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
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
            'Recuperar Vibe',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Insira seu email para recuperação de conta',
            style: GoogleFonts.inter(color: Color(colorGrey)),
          ),

          SizedBox(height: 15),

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

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: SizedBox(
                  width: 350,
                  height: 50,
                  child: PrimaryButton(
                    label: 'Enviar Codigo',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmailConfirmScreen(
                            onEmailConfirmed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResetPasswordScreen(),
                                ),
                              );
                            },
                          ),
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