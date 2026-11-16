import 'package:flutter/material.dart';
import 'package:laantech_download_manager/core/utils/formatters.dart';
import 'package:laantech_download_manager/features/files/domain/entities/file_entity.dart';

class TransferCard extends StatelessWidget {
  final FileEntity file;
  final VoidCallback? onSuffix;

  /// 0.0 to 1.0. Null when the file is not being transferred.
  final double? progressValue;

  const TransferCard({
    super.key,
    required this.file,
    this.onSuffix,
    this.progressValue,
  });

  @override
  Widget build(BuildContext context) {
    final progress = progressValue;
    final completed = progress == null ? null : (file.size * progress).round();

    return Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        shape: const Border(),
        collapsedShape: const Border(),
        title: Text(file.originalName),
        subtitle: progress == null
            ? Text(Formatters.bytes(file.size))
            : Row(
                children: [
                  Expanded(child: LinearProgressIndicator(value: progress)),
                  SizedBox(width: 8),
                  Text("${(progress * 100).toInt()}%"),
                ],
              ),
        trailing: onSuffix == null
            ? null
            : IconButton(onPressed: onSuffix, icon: const Icon(Icons.download)),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Row('Size', Formatters.bytes(file.size)),
          if (completed != null) ...[
            _Row('Completed', Formatters.bytes(completed)),
            _Row('Remaining', Formatters.bytes(file.size - completed)),
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
