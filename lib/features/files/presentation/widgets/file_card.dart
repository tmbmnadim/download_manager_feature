import 'package:flutter/material.dart';
import 'package:laantech_download_manager/core/utils/formatters.dart';
import 'package:laantech_download_manager/features/files/domain/entities/file_entity.dart';

class FileCard extends StatelessWidget {
  final FileEntity file;
  final VoidCallback? onDownload;

  const FileCard({super.key, required this.file, this.onDownload});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        shape: const Border(),
        collapsedShape: const Border(),
        title: Text(file.originalName),
        subtitle: Text(Formatters.bytes(file.size)),
        trailing: onDownload == null
            ? null
            : IconButton(
                onPressed: onDownload,
                icon: const Icon(Icons.download),
                tooltip: 'Download',
              ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Row('Size', Formatters.bytes(file.size)),
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
