import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laantech_download_manager/features/auth/presentation/widgets/logout_button.dart';
import 'package:laantech_download_manager/features/dashboard/domain/entities/transfer_entity.dart';
import 'package:laantech_download_manager/features/dashboard/presentation/bloc/transfers_bloc.dart';
import 'package:laantech_download_manager/features/dashboard/presentation/bloc/transfers_event.dart';
import 'package:laantech_download_manager/features/dashboard/presentation/bloc/transfers_state.dart';
import 'package:laantech_download_manager/features/dashboard/presentation/widgets/transfer_card.dart';
import 'package:laantech_download_manager/features/files/domain/entities/file_entity.dart';

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
          child: BlocConsumer<TransfersBloc, TransfersState>(
            listener: (context, state) {
              if (state is TransfersError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              switch (state) {
                case TransfersInitial():
                  return const Center(child: CircularProgressIndicator());
                case TransfersError(:final message):
                  return Center(child: Text(message));
                case TransfersLoaded():
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ongoing", style: theme.textTheme.titleLarge),
                      SizedBox(height: 8),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.transfers.length,
                          itemBuilder: (context, index) {
                            return TransferCard(
                              transfer: state.transfers[index],
                              onSuffix: () {
                                switch (state.transfers[index].status) {
                                  case TransferStatus.paused:
                                    context.read<TransfersBloc>().add(
                                      ResumeTransferEvent(
                                        state.transfers[index].id,
                                      ),
                                    );
                                  case TransferStatus.running:
                                    context.read<TransfersBloc>().add(
                                      PauseTransferEvent(
                                        state.transfers[index].id,
                                      ),
                                    );
                                  case TransferStatus.completed:
                                    break;
                                  default:
                                    break;
                                }
                              },
                            );
                          },
                        ),
                      ),
                      // SizedBox(height: 8),
                      // Text("Recent", style: theme.textTheme.titleLarge),
                      // SizedBox(height: 8),
                      // Expanded(
                      //   child: ListView.builder(
                      //     itemCount: 2,
                      //     itemBuilder: (context, index) {
                      //       return TransferCard(file: _sampleFile);
                      //     },
                      //   ),
                      // ),
                    ],
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
