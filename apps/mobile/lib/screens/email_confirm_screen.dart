import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/screens/profile_editing_screen.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/widgets/primary_button.dart';
import 'package:pinput/pinput.dart';

class EmailConfirmScreen extends StatefulWidget {
  const EmailConfirmScreen({super.key});

  @override
  State<EmailConfirmScreen> createState() => _EmailConfirmScreenState();
}

class _EmailConfirmScreenState extends State<EmailConfirmScreen> {
  @override
  Widget build(BuildContext context) {
    final defaultTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(colorAmbar),
      ),
      decoration: BoxDecoration(
        color: Color(colorAmbar).withOpacity(0.05),
        border: Border.all(
          color: Color(colorAmbar).withOpacity(0.3),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final focusedTheme = defaultTheme.copyWith(
      decoration: defaultTheme.decoration!.copyWith(
        border: Border.all(color: Color(colorAmbar), width: 2),
        color: Color(colorAmbar).withOpacity(0.08),
        boxShadow: [
          BoxShadow(
            color: Color(colorAmbar).withOpacity(0.25),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
    );

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
            'Verifique seu email',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.inter(color: Color(colorGrey), fontSize: 14),
              children: [
                TextSpan(
                  text: 'Enviamos um código de verificação para\n',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(colorGrey),
                  ),
                ),
                TextSpan(
                  text: 'email@example.com',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.orange,
                  ),
                ),
                TextSpan(
                  text:
                      '\n\nVerifique sua caixa de entrada e insira o\ncódigo abaixo para ativar sua conta ',
                ),
              ],
            ),
          ),

          SizedBox(height: 30),

          Pinput(
            length: 5,
            defaultPinTheme: defaultTheme,
            focusedPinTheme: focusedTheme,
          ),

          SizedBox(height: 50),

          PrimaryButton(
            label: 'Verificar e-mail',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileEditingScreen()),
              );
            },
          ),

          SizedBox(height: 12),
        ],
      ),
    );
  }
}
