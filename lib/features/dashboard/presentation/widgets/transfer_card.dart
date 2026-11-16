import 'package:flutter/material.dart';

class TransferCard extends StatelessWidget {
  final String filename;
  final String? path;
  final VoidCallback? onSuffix;
  final double? progressValue;
  const TransferCard({
    super.key,
    required this.filename,
    this.path,
    this.onSuffix,
    this.progressValue,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(filename),
        subtitle: path != null
            ? Text(path!)
            : progressValue == null
            ? null
            : LinearProgressIndicator(value: progressValue),
        trailing: onSuffix == null
            ? null
            : IconButton(onPressed: onSuffix, icon: Icon(Icons.download)),
      ),
    );
  }
}
