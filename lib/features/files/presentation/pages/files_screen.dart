import 'package:flutter/material.dart';
import 'package:laantech_download_manager/features/auth/presentation/widgets/logout_button.dart';
import 'package:laantech_download_manager/features/dashboard/presentation/widgets/transfer_card.dart';

class FilesScreen extends StatelessWidget {
  const FilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Files'),
        actions: const [LogoutButton()],
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Files", style: theme.textTheme.titleLarge),
              SizedBox(height: 8),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {},
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return TransferCard(
                        filename: "Something.extension",
                        onSuffix: () {},
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
