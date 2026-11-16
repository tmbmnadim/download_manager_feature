import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laantech_download_manager/core/di/dependency_injection.dart';
import 'package:laantech_download_manager/core/routes/app_routes.dart';
import 'package:laantech_download_manager/core/theme/theme.dart';
import 'package:laantech_download_manager/features/auth/presentation/bloc/auth_cubit.dart';

class DownloadManagerApp extends StatelessWidget {
  const DownloadManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dmTheme = DMTheme.themeWithDefaultTextTheme;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthCubit>()..restoreSession(),
          lazy: false,
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRoutes.router,
        theme: dmTheme.light(),
        darkTheme: dmTheme.dark(),
        highContrastTheme: dmTheme.lightHighContrast(),
        highContrastDarkTheme: dmTheme.darkHighContrast(),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
