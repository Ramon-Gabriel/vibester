import 'package:flutter/material.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/widgets/editing_avatar.dart';

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
      body: Column(
        children: [Center(heightFactor: 2, child: EditableAvatar())],
      ),
    );
  }
}
