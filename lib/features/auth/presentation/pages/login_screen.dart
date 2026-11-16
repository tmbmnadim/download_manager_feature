import 'package:flutter/material.dart';
import 'package:laantech_download_manager/core/theme/button_styles.dart';
import 'package:laantech_download_manager/core/widgets/dm_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Login", style: theme.textTheme.headlineLarge),
                SizedBox(height: 16),
                Text(
                  "Enter your email and password to login",
                  style: theme.textTheme.bodyLarge,
                ),
                SizedBox(height: 28),
                DMTextField(
                  controller: _emailController,
                  label: "Email",
                  hint: "something@example.com",
                ),
                SizedBox(height: 8),
                DMTextField(
                  controller: _passwordController,
                  label: "Password",
                  obscureText: _obscureText,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: DMButtonStyle.active(
                          Theme.of(context).colorScheme,
                        ),
                        child: Text("Login"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
