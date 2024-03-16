import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nexonetics_task/model/media_item_model.dart';
import 'package:path/path.dart';

// ... rest of your code

class Controller with ChangeNotifier {
  List<String> images = [
    "https://www.bing.com/th?id=OADD2.10239315184108_1ZDLD2KO4ZF4CGCQO&pid=21.2&c=16&roil=0&roit=0.0348&roir=1&roib=0.9652&w=268&h=140&dynsize=1&qlt=90",
    "https://th.bing.com/th?id=ORMS.ef6f8a3f20ceb0f7ae0c3dbdae80733f&pid=Wdp&w=300&h=156&qlt=90&c=1&rs=1&dpr=1.25&p=0",
    "https://th.bing.com/th?id=ORMS.66a62229764c320a8d627ccd7ee51580&pid=Wdp&w=300&h=156&qlt=90&c=1&rs=1&dpr=1.25&p=0",
    "https://www.bing.com/th?id=OADD2.7353105520034_1GDKVNOZ9R5V03SCO6&pid=21.2&c=3&w=300&h=157&dynsize=1&qlt=90",
    "https://th.bing.com/th?id=ORMS.a46413c245d19fcd6bb25ccb04fefef4&pid=Wdp&w=300&h=156&qlt=90&c=1&rs=1&dpr=1.25&p=0",
    "https://th.bing.com/th?id=ORMS.611948f792884fb135461bc36d41557d&pid=Wdp&w=300&h=156&qlt=90&c=1&rs=1&dpr=1.25&p=0"
  ];
  int selectedIndex = 0;
  PageController pageController = PageController();
  String fileName = "";
  final _db = FirebaseFirestore.instance;
  Future<void> pickAndUploadMedia() async {
    final pickedFile = await pickImageOrVideo();
    print("Picked file : $pickedFile");
    if (pickedFile != null) {
      // Process and compress video if it's a video
      // final compressedFile = pickedFile.type == 'video'
      //     ? await compressVideo(pickedFile)
      //     : pickedFile;
      // final mediaType = pickedFile.mimeType;
      print("Name : ${pickedFile.name}");
      print("Return type : ${pickedFile.runtimeType.toString()}");
      print("to String : ${pickedFile.toString()}");

      String type = await checkFileType(pickedFile);
      // if (mediaType != null) {
      //   print("mediatipe: $mediaType");

      //   if (mediaType.startsWith('image/jpeg') ||
      //       mediaType.startsWith('image/png') ||
      //       mediaType.startsWith('image/gif')) {
      //     type = 'image';
      //   } else if (mediaType.startsWith('video/mp4') ||
      //       mediaType.startsWith('video/quicktime')) {
      //     type = 'video';
      //   } else {
      //     type = 'unsupported';
      //   }
      // }

      print("type:  $type");
      final uploadUrl = await uploadFile(pickedFile.path);
      print("uploadurl: $uploadUrl");
      if (uploadUrl != null) {
        final media = MediaItemModel(url: uploadUrl, type: type, size: "20");
        await addMedia(media);
      }
      // setState(() {
      //   _mediaItems.add(MediaItem(
      //     id: UniqueKey().toString(),
      //     url: uploadUrl,
      //     type: pickedFile.type,
      //   ));
      // });
    }
  }

  open(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  Future<XFile?> pickImageOrVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickMedia();
    return pickedFile;
  }

  Future<String?> uploadFile(String filePath) async {
    try {
      fileName = basename(filePath);
      final storageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');
      final uploadTask = storageRef.putFile(File(filePath));
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Exeption : $e");
      return null;
    }
  }

  Future<String> checkFileType(XFile? pickedFile) async {
    final _pickedMedia = File(pickedFile!.path);

    final String? mimeType = await _pickedMedia.readAsBytes().then((value) {
      final List<int> bytes = value;
      if (bytes.length >= 8) {
        if (bytes[0] == 0x52 &&
            bytes[1] == 0x49 &&
            bytes[2] == 0x46 &&
            bytes[3] == 0x46 &&
            bytes[8] == 0x57 &&
            bytes[9] == 0x41 &&
            bytes[10] == 0x56 &&
            bytes[11] == 0x45) {
          return 'video/mp4';
        }
      }
      return null;
    });

    if (mimeType != null) {
      return "video";
    } else {
      return "photo";
    }
  }

  addMedia(MediaItemModel media) async {
    try {
      await _db.collection("Media").add(media.toJson());
    } catch (e) {
      print(e.toString());
    }
  }
}
