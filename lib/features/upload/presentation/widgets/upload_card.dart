import 'package:flutter/material.dart';

class UploadCard extends StatelessWidget {
  const UploadCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 200,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(),
              Spacer(),
              if (false)
                _selectAFile()
              else
                _fileDetails(
                  "storage/emulated/0/somefile.extension",
                  "1532.5432 Mb",
                ),
              Spacer(),
              if (true)
                LinearProgressIndicator(value: 0.4)
              else
                SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectAFile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Click to select a file"),
        SizedBox(height: 16),
        Icon(Icons.upload_file, size: 36),
      ],
    );
  }

  Widget _fileDetails(String path, String size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text("File: $path"), Text("Size: $size")],
    );
  }
}
