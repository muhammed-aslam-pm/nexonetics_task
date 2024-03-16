import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nexonetics_task/model/media_item_model.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

// ... rest of your code

class Controller with ChangeNotifier {
  int selectedIndex = 0;

  final _db = FirebaseFirestore.instance;
  List<MediaItemModel> videos = [];
  List<MediaItemModel> photos = [];

  // Future<void> pickAndUploadMedia() async {
  //   final pickedFile = await pickImageOrVideo();
  //   print("Picked file : $pickedFile");
  //   if (pickedFile != null) {
  //     // Process and compress video if it's a video
  //     // final compressedFile = pickedFile.type == 'video'
  //     //     ? await compressVideo(pickedFile)
  //     //     : pickedFile;
  //     // final mediaType = pickedFile.mimeType;
  //     print("Name : ${pickedFile.name}");
  //     print("Return type : ${pickedFile.runtimeType.toString()}");
  //     print("to String : ${pickedFile.toString()}");

  //     String type = await checkFileType(pickedFile);
  //     // if (mediaType != null) {
  //     //   print("mediatipe: $mediaType");

  //     //   if (mediaType.startsWith('image/jpeg') ||
  //     //       mediaType.startsWith('image/png') ||
  //     //       mediaType.startsWith('image/gif')) {
  //     //     type = 'image';
  //     //   } else if (mediaType.startsWith('video/mp4') ||
  //     //       mediaType.startsWith('video/quicktime')) {
  //     //     type = 'video';
  //     //   } else {
  //     //     type = 'unsupported';
  //     //   }
  //     // }

  //     print("type:  $type");
  //     final uploadUrl = await uploadFile(pickedFile.path);
  //     print("uploadurl: $uploadUrl");
  //     if (uploadUrl != null) {
  //       final media = MediaItemModel(
  //           title: pickedFile.name, url: uploadUrl, type: type, size: "20");
  //       await addMedia(media);
  //       await fetchMedias();
  //     }
  //     // setState(() {
  //     //   _mediaItems.add(MediaItem(
  //     //     id: UniqueKey().toString(),
  //     //     url: uploadUrl,
  //     //     type: pickedFile.type,
  //     //   ));
  //     // });
  //   }
  // }

  uploadPhoto(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final uploadUrl = await uploadFile(pickedFile.path);

      if (uploadUrl != null) {
        final media = MediaItemModel(
            title: pickedFile.name,
            url: uploadUrl,
            type: "photo",
            size: "20",
            date: DateTime.now());
        await addPhoto(media);
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Photo Uploaded!")));
        await fetchMedias();
      }
    }
  }

  uploadVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final uploadUrl = await uploadFile(pickedFile.path);

      if (uploadUrl != null) {
        final media = MediaItemModel(
            title: pickedFile.name,
            url: uploadUrl,
            type: "video",
            size: "20",
            date: DateTime.now());
        await addVideo(media);
        await fetchMedias();
      }
    }
  }

  fetchMedias() async {
    try {
      final videoResults = await _db.collection("Videos").get();
      final videoFiles = videoResults.docs
          .map((documentSnapshot) =>
              MediaItemModel.fromSnapshot(documentSnapshot))
          .toList();
      videos = videoFiles;
      final photoResults = await _db.collection("Photos").get();
      final photoFiles = photoResults.docs
          .map((documentSnapshot) =>
              MediaItemModel.fromSnapshot(documentSnapshot))
          .toList();
      photos = photoFiles;
      print(photos);
      notifyListeners();
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  deletePhoto({required BuildContext context, required String id}) async {
    try {
      await _db.collection('Photos').doc(id).delete();
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Photo Deleted!")));
      fetchMedias();
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  open(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  Future<String?> uploadFile(String filePath) async {
    try {
      final fileName = basename(filePath);
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

  Future<void> downloadFile(String url, BuildContext context) async {
    final fileName = basename(url);
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final response = await http.get(Uri.parse(url));
    print("Response Status Code: ${response.statusCode}");
    if (response.statusCode == 200) {
      await File(filePath).writeAsBytes(response.bodyBytes);
      print("File downloaded to: $filePath");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Download Successfull!")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Download Filed!")));
    }
  }

  Future<void> launchURL(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  addVideo(MediaItemModel media) async {
    try {
      await _db.collection("Videos").add(media.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  addPhoto(MediaItemModel media) async {
    try {
      await _db.collection("Photos").add(media.toJson());
    } catch (e) {
      print(e.toString());
    }
  }
}
