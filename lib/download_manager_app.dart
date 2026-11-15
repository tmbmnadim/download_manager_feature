import 'package:flutter/material.dart';
import 'package:laantech_download_manager/core/routes/app_routes.dart';
import 'package:laantech_download_manager/core/theme/theme.dart';

class DownloadManagerApp extends StatelessWidget {
  const DownloadManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dmTheme = DMTheme.themeWithDefaultTextTheme;

    return MaterialApp.router(
      routerConfig: AppRoutes.router,
      theme: dmTheme.light(),
      darkTheme: dmTheme.dark(),
      highContrastTheme: dmTheme.lightHighContrast(),
      highContrastDarkTheme: dmTheme.darkHighContrast(),
      themeMode: ThemeMode.system,
    );
  }
}
