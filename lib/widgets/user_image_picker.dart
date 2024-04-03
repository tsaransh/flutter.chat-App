import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.pickedImage});

  final void Function(File pickedImage) pickedImage;

  @override
  State<UserImagePicker> createState() {
    return _UserImagePickerState();
  }
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _userPickedImage;

  void pickImage() async {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _userPickedImage = File(pickedImage.path);
    });
    widget.pickedImage(_userPickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickImage,
      onDoubleTap: () {
        setState(() {
          _userPickedImage = null;
        });
      },
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey,
        backgroundImage: const AssetImage('assets/images/logo.png'),
        foregroundImage:
            _userPickedImage != null ? FileImage(_userPickedImage!) : null,
      ),
    );
  }
}
