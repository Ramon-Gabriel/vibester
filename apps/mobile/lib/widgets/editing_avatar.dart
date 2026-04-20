import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/utils/colors.dart';

class EditableAvatar extends StatefulWidget {
  final String? imageUrl;
  final ValueChanged<File>? onImageChanged;

  const EditableAvatar({super.key, this.imageUrl, this.onImageChanged});

  @override
  State<EditableAvatar> createState() => _EditableAvatarState();
}

class _EditableAvatarState extends State<EditableAvatar> {
  File? _image;

  Future<void> _pick(ImageSource source) async {
    final picked = await ImagePicker().pickImage(
      source: source,
      imageQuality: 85,
    );
    if (picked == null) return;
    final file = File(picked.path);
    setState(() => _image = file);
    widget.onImageChanged?.call(file);
  }

  void _showOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_camera_outlined),
            title: const Text('Câmera'),
            onTap: () {
              Navigator.pop(context);
              _pick(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: const Text('Galeria'),
            onTap: () {
              Navigator.pop(context);
              _pick(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  ImageProvider? get _provider {
    if (_image != null) return FileImage(_image!);
    if (widget.imageUrl != null) return NetworkImage(widget.imageUrl!);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showOptions,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(colorAmbar).withAlpha(150), // 👈 cor da borda
                width: 2, // 👈 espessura
              ),
            ),
            child: CircleAvatar(
              backgroundColor: Color(colorDarkGrey).withAlpha(150),
              radius: 48,
              backgroundImage: _provider,
              child: _provider == null
                  ? Icon(Icons.person, color: Colors.white, size: 50)
                  : null,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              radius: 48 * 0.28,
              backgroundColor: Color(colorAmbar),
              child: Icon(Icons.edit, size: 48 * 0.28, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
