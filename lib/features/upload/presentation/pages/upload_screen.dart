import 'package:flutter/material.dart';
import 'package:laantech_download_manager/features/auth/presentation/widgets/logout_button.dart';
import 'package:laantech_download_manager/core/theme/button_styles.dart';
import 'package:laantech_download_manager/features/upload/presentation/widgets/upload_card.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload'),
        actions: const [LogoutButton()],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            children: [
              UploadCard(),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: DMButtonStyle.active(Theme.of(context).colorScheme),
                child: Text("Start Upload"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
