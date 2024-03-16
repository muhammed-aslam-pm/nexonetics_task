class MediaItemModel {
  final String? id;
  final String url;
  final String type;
  final int size;

  MediaItemModel(
      {this.id, required this.url, required this.type, required this.size});

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'type': type,
        'size': size,
      };

  factory MediaItemModel.fromJson(Map<String, dynamic> json) => MediaItemModel(
        id: json['id'] as String,
        url: json['url'] as String,
        type: json['type'] as String,
        size: json['size'] as int,
      );
}
