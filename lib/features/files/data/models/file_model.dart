import 'package:laantech_download_manager/features/files/domain/entities/file_entity.dart';

class FileModel extends FileEntity {
  const FileModel({
    required super.id,
    required super.name,
    required super.originalName,
    required super.size,
    required super.type,
    required super.uploadedAt,
    required super.url,
  });

  /// Parses one file object, as returned by `GET /get` (inside `files`)
  /// and by `POST /upload` (inside `file`).
  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      id: json['id'] as int,
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      size: json['size'] as int,
      type: json['type'] as String,
      uploadedAt: DateTime.parse(json['uploaded_at'] as String),
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'original_name': originalName,
    'size': size,
    'type': type,
    'uploaded_at': uploadedAt.toIso8601String(),
    'url': url,
  };
}
