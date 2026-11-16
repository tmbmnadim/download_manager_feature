import 'dart:convert';

import 'package:background_downloader/background_downloader.dart';
import 'package:injectable/injectable.dart';
import 'package:laantech_download_manager/core/network/dio_client.dart';
import 'package:laantech_download_manager/features/files/data/models/file_model.dart';

@injectable
class TransfersNetworkSource {
  final FileDownloader _fileDownloader;
  final ApiService _apiService;
  TransfersNetworkSource(this._fileDownloader, this._apiService);

  /// Enqueues the download and returns the task that was created.
  Future<DownloadTask> downloadFile(FileModel file) async {
    final task = DownloadTask(
      taskId: file.id.toString(),
      url: file.url,
      filename: file.name,
      allowPause: true,
      headers: _apiService.authHeaders, // read now, so it is the current token
      displayName: file.originalName,
      creationTime: file.uploadedAt,
      updates: Updates.statusAndProgress,
      metaData: jsonEncode(file.toJson()), // lets us rebuild the file later
      retries: 2,
    );

    final didEnqueue = await _fileDownloader.enqueue(task);
    if (!didEnqueue) throw Exception("Failed to start download");
    return task;
  }

  Future<bool> pause(String taskId) async {
    final task = await _fileDownloader.taskForId(taskId);
    return task is DownloadTask ? _fileDownloader.pause(task) : false;
  }

  Future<bool> resume(String taskId) async {
    final task = await _fileDownloader.taskForId(taskId);
    return task is DownloadTask ? _fileDownloader.resume(task) : false;
  }

  Future<bool> cancel(String taskId) =>
      _fileDownloader.cancelTaskWithId(taskId);

  Stream<TaskUpdate> getTaskUpdateStream() => _fileDownloader.updates;

  Future<void> resumeFromBackground() => _fileDownloader.resumeFromBackground();
}
