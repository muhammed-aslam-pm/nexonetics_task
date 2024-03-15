import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Controller with ChangeNotifier {
  Future<XFile?> pickImageOrVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickMedia();
    return pickedFile;
  }
}
