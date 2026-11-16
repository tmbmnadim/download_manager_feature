import 'package:go_router/go_router.dart';
import 'package:laantech_download_manager/core/navigation/main_shell.dart';
import 'package:laantech_download_manager/features/auth/presentation/pages/login_screen.dart';
import 'package:laantech_download_manager/features/dashboard/presentation/pages/dashboard.dart';
import 'package:laantech_download_manager/features/files/presentation/pages/files_screen.dart';
import 'package:laantech_download_manager/features/upload/presentation/pages/upload_screen.dart';

class AppRoutes {
  static String get login => "/login";
  static String get files => "/files";
  static String get dashboard => "/dashboard";
  static String get upload => "/upload";

  static final List<RouteBase> _routes = [
    GoRoute(path: login, builder: (context, state) => const LoginScreen()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: files,
              builder: (context, state) => const FilesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: dashboard,
              builder: (context, state) => const TransfersDashboardScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: upload,
              builder: (context, state) => const UploadScreen(),
            ),
          ],
        ),
      ],
    ),
  ];

  static final GoRouter router = GoRouter(
    initialLocation: login,
    routes: _routes,
  );
}
