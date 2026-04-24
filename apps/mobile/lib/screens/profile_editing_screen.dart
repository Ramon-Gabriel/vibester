import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/widgets/date_picker_field.dart';
import 'package:mobile/widgets/editing_avatar.dart';
import 'package:mobile/widgets/primary_button.dart';
import 'package:mobile/widgets/primary_text_field.dart';

class ProfileEditingScreen extends StatefulWidget {
  const ProfileEditingScreen({super.key});

  @override
  State<ProfileEditingScreen> createState() => _ProfileEditingScreenState();
}

class _ProfileEditingScreenState extends State<ProfileEditingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(colorDarkGrey),
      appBar: AppBar(
        title: Text('Informacoes pessoais'),
        backgroundColor: Color(colorDarkGrey),
        foregroundColor: Colors.white,
        titleTextStyle: GoogleFonts.inter(fontSize: 20),
      ),
      body: Column(
        children: [
          Center(heightFactor: 2, child: EditableAvatar()),
          PrimaryTextField(labelText: 'Nome', height: 60),
          SizedBox(height: 25),
          DatePickerField(labelText: 'Data de Nascimento', height: 60),
          SizedBox(height: 25),
          PrimaryTextField(labelText: 'Nome de usuário', height: 60),
          SizedBox(height: 25),
          PrimaryTextField(labelText: 'Bio', height: 90),
          SizedBox(height: 25),
          PrimaryButton(label: 'Cadastrar', onPressed: () {}),
        ],
      ),
    );
  }
}
