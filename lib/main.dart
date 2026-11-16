import 'package:flutter/material.dart';
import 'package:laantech_download_manager/core/di/dependency_injection.dart';

import 'download_manager_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const DownloadManagerApp());
}
