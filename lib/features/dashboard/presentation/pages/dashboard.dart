import 'package:flutter/material.dart';
import 'package:laantech_download_manager/features/auth/presentation/widgets/logout_button.dart';
import 'package:laantech_download_manager/features/dashboard/presentation/widgets/transfer_card.dart';
import 'package:laantech_download_manager/features/files/domain/entities/file_entity.dart';

// Placeholder until the transfer state is wired in.
final _sampleFile = FileEntity(
  id: 1,
  name: 'sample_86c01db4.pdf',
  originalName: 'Something.extension',
  size: 1605632000,
  type: 'application/pdf',
  uploadedAt: DateTime(2026, 11, 16, 10, 30),
  url: '',
);

class TransfersDashboardScreen extends StatelessWidget {
  const TransfersDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: const [LogoutButton()],
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Ongoing", style: theme.textTheme.titleLarge),
              SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return TransferCard(
                      file: _sampleFile,
                      onSuffix: () {},
                      progressValue: 0.4,
                    );
                  },
                ),
              ),
              SizedBox(height: 8),
              Text("Recent", style: theme.textTheme.titleLarge),
              SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return TransferCard(file: _sampleFile);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
