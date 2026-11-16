import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laantech_download_manager/core/widgets/dm_snackbar.dart';
import 'package:laantech_download_manager/features/auth/presentation/widgets/logout_button.dart';
import 'package:laantech_download_manager/features/dashboard/presentation/bloc/transfers_bloc.dart';
import 'package:laantech_download_manager/features/dashboard/presentation/bloc/transfers_event.dart';
import 'package:laantech_download_manager/features/files/presentation/bloc/files_cubit.dart';
import 'package:laantech_download_manager/features/files/presentation/bloc/files_state.dart';
import 'package:laantech_download_manager/features/files/presentation/widgets/file_card.dart';

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
      body: BlocListener<FilesCubit, FilesState>(
        listener: (context, state) {
          if (state is FilesError) {
            DMSnackbar.show(context, state.message);
          }
        },
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<FilesCubit, FilesState>(
              builder: (context, state) {
                switch (state) {
                  case FilesInitial():
                  case FilesLoading():
                    return Center(child: CircularProgressIndicator());
                  case FilesError():
                    return Center(child: Text("No Files to Show"));
                  case FilesFetched():
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Files", style: theme.textTheme.titleLarge),
                        SizedBox(height: 8),
                        if (state.files.isEmpty)
                          Center(child: Text("No Files to Show"))
                        else
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: context.read<FilesCubit>().getFiles,
                              child: ListView.builder(
                                physics: AlwaysScrollableScrollPhysics(),
                                itemCount: state.files.length,
                                itemBuilder: (context, index) {
                                  return FileCard(
                                    file: state.files[index],
                                    onDownload: () {
                                      context.read<TransfersBloc>().add(
                                        StartTransferEvent(state.files[index]),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                      ],
                    );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
