import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:laantech_download_manager/core/error/dio_error_mapper.dart';
import 'package:laantech_download_manager/core/error/failure.dart';
import 'package:laantech_download_manager/features/files/data/datasources/file_remote_source.dart';
import 'package:laantech_download_manager/features/files/domain/entities/file_entity.dart';
import 'package:laantech_download_manager/features/files/domain/repositories/file_repository.dart';

@Injectable(as: FileRepository)
class FileRepositoryImpl implements FileRepository {
  final FileRemoteSource _remote;
  FileRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, List<FileEntity>>> getFiles() async {
    try {
      final result = await _remote.getFiles();
      return right(result.files);
    } on DioException catch (e) {
      return left(e.toFailure());
    } on FormatException {
      return left(const Failure('Unexpected response from the server.'));
    } on TypeError {
      return left(const Failure('Unexpected response from the server.'));
    }
  }
}
