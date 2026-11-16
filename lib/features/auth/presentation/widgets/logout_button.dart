import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:laantech_download_manager/core/routes/app_routes.dart';
import 'package:laantech_download_manager/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:laantech_download_manager/features/auth/presentation/bloc/auth_states.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      // Only react to an actual logout, not to the startup session check.
      listenWhen: (previous, current) =>
          previous is Authenticated && current is Unauthenticated,
      listener: (context, state) => context.go(AppRoutes.login),
      child: IconButton(
        tooltip: 'Logout',
        icon: const Icon(Icons.logout),
        onPressed: () => context.read<AuthCubit>().logout(),
      ),
    );
  }
}
