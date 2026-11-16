import 'package:flutter/material.dart';
import 'package:laantech_download_manager/core/utils/formatters.dart';
import 'package:laantech_download_manager/features/dashboard/domain/entities/transfer_entity.dart';

class TransferCard extends StatelessWidget {
  final TransferEntity transfer;
  final VoidCallback? onSuffix;

  const TransferCard({super.key, required this.transfer, this.onSuffix});

  @override
  Widget build(BuildContext context) {
    final file = transfer.file;
    final progress = transfer.progress;
    final status = transfer.status;
    Icon icon = const Icon(Icons.download);
    switch (status) {
      case TransferStatus.queued:
        icon = const Icon(Icons.queue);
      case TransferStatus.running:
        icon = const Icon(Icons.downloading);
      case TransferStatus.paused:
        icon = const Icon(Icons.pause_circle);
      case TransferStatus.completed:
        icon = const Icon(Icons.check_circle);
      case TransferStatus.canceled:
        icon = const Icon(Icons.cancel);
      case TransferStatus.failed:
        icon = Icon(Icons.error, color: Theme.of(context).colorScheme.error);
    }

    return Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        shape: const Border(),
        collapsedShape: const Border(),
        title: Text(file.originalName),
        subtitle: status == TransferStatus.failed
            ? Text(
                transfer.errorMessage ?? 'Transfer failed.',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              )
            : Row(
                children: [
                  Expanded(child: LinearProgressIndicator(value: progress)),
                  SizedBox(width: 8),
                  Text("${(progress * 100).toInt()}%"),
                ],
              ),
        trailing: onSuffix == null
            ? null
            : IconButton(onPressed: onSuffix, icon: icon),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (status == TransferStatus.failed)
            _Row('Error', transfer.errorMessage ?? 'Transfer failed.'),
          _Row('Size', Formatters.bytes(file.size)),
          if (status == TransferStatus.completed) ...[
            _Row('Completed', Formatters.bytes(transfer.completedBytes)),
            _Row('Remaining', Formatters.bytes(transfer.remainingBytes)),
          ],
          _Row('Type', file.type),
          _Row('Uploaded', Formatters.date(file.uploadedAt)),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(child: Text(value, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
