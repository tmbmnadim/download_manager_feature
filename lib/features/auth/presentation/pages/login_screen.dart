import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:laantech_download_manager/core/routes/app_routes.dart';
import 'package:laantech_download_manager/core/theme/button_styles.dart';
import 'package:laantech_download_manager/core/utils/validators.dart';
import 'package:laantech_download_manager/core/widgets/dm_snackbar.dart';
import 'package:laantech_download_manager/core/widgets/dm_text_field.dart';
import 'package:laantech_download_manager/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:laantech_download_manager/features/auth/presentation/bloc/auth_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().login(
      _usernameController.text.trim(),
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        top: false,
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              context.go(AppRoutes.dashboard);
            } else if (state is AuthError) {
              DMSnackbar.show(context, state.message);
            }
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Login", style: theme.textTheme.headlineLarge),
                    SizedBox(height: 16),
                    Text(
                      "Enter your username and password to login",
                      style: theme.textTheme.bodyLarge,
                    ),
                    SizedBox(height: 28),
                    DMTextField(
                      controller: _usernameController,
                      label: "Username",
                      validator: Validators.username,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 8),
                    DMTextField(
                      controller: _passwordController,
                      label: "Password",
                      obscureText: _obscureText,
                      validator: Validators.password,
                      textInputAction: TextInputAction.done,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        final loading = state is AuthLoading;
                        Widget child = const Text("Login");
                        if (loading) {
                          child = const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        }
                        return Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: loading ? null : _submit,
                                style: loading
                                    ? DMButtonStyle.deactive(
                                        Theme.of(context).colorScheme,
                                      )
                                    : DMButtonStyle.active(
                                        Theme.of(context).colorScheme,
                                      ),
                                child: child,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
