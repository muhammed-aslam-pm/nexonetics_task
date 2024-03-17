// ignore_for_file: use_build_context_synchronously, avoid_print
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nexonetics_task/model/media_item_model.dart';
import 'package:nexonetics_task/utils/color_constants.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class Controller with ChangeNotifier {
  int selectedIndex = 0;

  final _db = FirebaseFirestore.instance;
  List<MediaItemModel> videos = [];
  List<MediaItemModel> photos = [];
  List<Widget> thumbnails = [];
//------------------------------------------------------------------------------Upload Photo
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
            .showSnackBar(const SnackBar(content: Text("Photo Uploaded!")));
        await fetchMedias();
      }
    }
  }

//------------------------------------------------------------------------------Upload Video
  uploadVideo(BuildContext context) async {
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
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Video Uploaded!")));
        await fetchMedias();
      }
    }
  }

//------------------------------------------------------------------------------Fetch All Medias
  fetchMedias() async {
    try {
      final videoResults = await _db.collection("Videos").get();
      final videoFiles = videoResults.docs
          .map((documentSnapshot) =>
              MediaItemModel.fromSnapshot(documentSnapshot))
          .toList();
      videos = videoFiles;
      notifyListeners();
      final photoResults = await _db.collection("Photos").get();
      final photoFiles = photoResults.docs
          .map((documentSnapshot) =>
              MediaItemModel.fromSnapshot(documentSnapshot))
          .toList();
      photos = photoFiles;
      notifyListeners();
      if (videos.isNotEmpty) {
        thumbnails = await fetchThumbnails(videos);
      }
      print(photos);
      notifyListeners();
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

//------------------------------------------------------------------------------Delete Photo
  deletePhoto({required BuildContext context, required String id}) async {
    try {
      await _db.collection('Photos').doc(id).delete();
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Photo Deleted!")));
      fetchMedias();
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

//------------------------------------------------------------------------------Delete Video
  deleteVideo({required BuildContext context, required String id}) async {
    try {
      await _db.collection('Videos').doc(id).delete();
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Viedo Deleted!")));
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

//------------------------------------------------------------------------------Upload Files to Firebase Storage
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

  // Future<void> downloadFile(String url, BuildContext context) async {
  //   final fileName = basename(url);
  //   final directory = await getTemporaryDirectory();
  //   final filePath = '${directory.path}/$fileName';
  //   final response = await http.get(Uri.parse(url));
  //   print("Response Status Code: ${response.statusCode}");
  //   if (response.statusCode == 200) {
  //     await File(filePath).writeAsBytes(response.bodyBytes);
  //     print("File downloaded to: $filePath");
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("Download Successfull!")));
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("Download Filed!")));
  //   }
  // }
//------------------------------------------------------------------------------URL Launcher for downloading
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

//------------------------------------------------------------------------------Fetch Video thumbniles
  Future<List<Widget>> fetchThumbnails(List<MediaItemModel> videos) async {
    List<Widget> tempThumbnails = [];
    for (MediaItemModel url in videos) {
      Uint8List? bytes = await VideoThumbnail.thumbnailData(
        video: url.url,
        imageFormat: ImageFormat.PNG,
        maxWidth: 150,
        quality: 25,
      );
      if (bytes != null) {
        tempThumbnails.add(Image.memory(bytes));
      } else {
        tempThumbnails.add(Center(
          child: Icon(
            Icons.image_not_supported,
            color: ColorConstants.colorGrey,
          ),
        ));
      }
    }

    return tempThumbnails;
  }

//------------------------------------------------------------------------------add video to firebase database
  addVideo(MediaItemModel media) async {
    try {
      await _db.collection("Videos").add(media.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

//------------------------------------------------------------------------------add photo to firebase database
  addPhoto(MediaItemModel media) async {
    try {
      await _db.collection("Photos").add(media.toJson());
    } catch (e) {
      print(e.toString());
    }
  }
}
