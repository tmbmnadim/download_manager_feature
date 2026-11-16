import 'package:fpdart/fpdart.dart';
import 'package:laantech_download_manager/core/error/failure.dart';
import 'package:laantech_download_manager/features/files/domain/entities/file_entity.dart';

abstract class FileRepository {
  /// Files previously uploaded to the server.
  Future<Either<Failure, List<FileEntity>>> getFiles();
}
