import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:windrop/core/application/viewmodels/file_vm.dart';
import 'package:windrop/core/domain/entities/file_model.dart';

class FileList extends ConsumerWidget {
  final List<FileModel> files;

  const FileList({super.key, required this.files});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: files.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final file = files[index];
        return ListTile(
          leading: const Icon(Icons.insert_drive_file),
          title: Text(file.filename),
          subtitle: Text(_formatFileSize(file.size)),
          trailing: IconButton(
            icon: const Icon(Icons.download),
            onPressed: () async {
              final path = await ref
                  .read(fileViewModelProvider.notifier)
                  .downloadFile(file.id, file.filename);
              if (path != null && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('File downloaded to: $path')),
                );
              }
            },
          ),
        );
      },
    );
  }

  String _formatFileSize(int bytes) {
    const suffixes = ['B', 'KB', 'MB', 'GB'];
    var i = 0;
    double size = bytes.toDouble();

    while (size >= 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }

    return '${size.toStringAsFixed(2)} ${suffixes[i]}';
  }
}
