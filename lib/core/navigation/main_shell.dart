import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:laantech_download_manager/core/di/dependency_injection.dart';
import 'package:laantech_download_manager/features/dashboard/presentation/bloc/transfers_bloc.dart';
import 'package:laantech_download_manager/features/dashboard/presentation/bloc/transfers_event.dart';
import 'package:laantech_download_manager/features/files/presentation/bloc/files_cubit.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<FilesCubit>()..getFiles(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) =>
              getIt<TransfersBloc>()..add(const WatchTransfersEvent()),
          lazy: true,
        ),
      ],
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (i) => navigationShell.goBranch(
            i,
            initialLocation: i == navigationShell.currentIndex,
          ),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.folder), label: 'Files'),
            NavigationDestination(
              icon: Icon(Icons.swap_vert),
              label: 'Dashboard',
            ),
            NavigationDestination(
              icon: Icon(Icons.upload_file),
              label: 'Upload',
            ),
          ],
        ),
      ),
    );
  }
}
