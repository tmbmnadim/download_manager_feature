import 'package:laantech_download_manager/features/files/data/models/file_model.dart';

class FileListResponseModel {
  final int count;
  final List<FileModel> files;

  const FileListResponseModel({required this.count, required this.files});

  /// Parses the `GET /get` response.
  factory FileListResponseModel.fromJson(Map<String, dynamic> json) {
    final files = (json['files'] as List)
        .map((e) => FileModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return FileListResponseModel(
      count: json['count'] as int? ?? files.length,
      files: files,
    );
  }
}
