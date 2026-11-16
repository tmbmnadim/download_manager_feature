import 'package:flutter/material.dart';

class TransferCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onSuffix;
  final double? progressValue;
  const TransferCard({
    super.key,
    required this.title,
    this.subtitle,
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
        title: Text(title),
        subtitle: subtitle != null
            ? Text(subtitle!)
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
