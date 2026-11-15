import 'package:go_router/go_router.dart';
import 'package:laantech_download_manager/features/transfers/presentation/pages/dashboard.dart';

class AppRoutes {
  static final List<RouteBase> _routes = [
    GoRoute(
      path: "/dashboard",
      builder: (context, state) => const TransfersDashboardScreen(),
    ),
  ];

  static GoRouter get router => GoRouter(initialExtra: "", routes: _routes);
}
