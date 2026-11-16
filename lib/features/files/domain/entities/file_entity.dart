import 'package:equatable/equatable.dart';

class FileEntity extends Equatable {
  final int id;

  /// Unique name on the server; used to download (`/get?file=NAME`).
  final String name;
  final String originalName;

  /// Size in bytes.
  final int size;
  final String type;
  final DateTime uploadedAt;
  final String url;

  const FileEntity({
    required this.id,
    required this.name,
    required this.originalName,
    required this.size,
    required this.type,
    required this.uploadedAt,
    required this.url,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    originalName,
    size,
    type,
    uploadedAt,
    url,
  ];
}
