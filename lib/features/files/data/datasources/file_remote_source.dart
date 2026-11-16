import 'package:injectable/injectable.dart';
import 'package:laantech_download_manager/core/constants/api_constants.dart';
import 'package:laantech_download_manager/core/network/dio_client.dart';
import 'package:laantech_download_manager/features/files/data/models/file_list_response_model.dart';

@injectable
class FileRemoteSource {
  final ApiService _apiService;
  FileRemoteSource({required this._apiService});

  Future<FileListResponseModel> getFiles() async {
    final response = await _apiService.dio.get("${ApiConstants.baseUrl}/get");

    return FileListResponseModel.fromJson(response.data);
  }
}
