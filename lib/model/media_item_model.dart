import 'package:cloud_firestore/cloud_firestore.dart';

class MediaItemModel {
  final String? id;
  final String url;
  final String type;
  final String size;
  final String title;
  final DateTime date;

  MediaItemModel(
      {this.id,
      required this.title,
      required this.date,
      required this.url,
      required this.type,
      required this.size});

  Map<String, dynamic> toJson() => {
        'url': url,
        'title': title,
        'date': date,
        'type': type,
        'size': size,
      };

  factory MediaItemModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return MediaItemModel(
        id: document.id,
        title: data['title'] as String,
        date: (data['date'] as Timestamp).toDate(),
        url: data['url'] as String,
        type: data['type'] as String,
        size: data['size'] as String,
      );
    } else {
      return MediaItemModel.empty();
    }
  }
  static MediaItemModel empty() => MediaItemModel(
      id: "", url: "", type: "", size: "", title: "", date: DateTime.now());
}
