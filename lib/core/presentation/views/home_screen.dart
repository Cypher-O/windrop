import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:windrop/core/application/viewmodels/file_vm.dart';
import 'package:windrop/core/presentation/widgets/file_list.dart';
import 'package:windrop/core/presentation/widgets/upload_area.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileState = ref.watch(fileViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Windrop'),
        elevation: 0,
      ),
      body: Column(
        children: [
          const UploadArea(),
          Expanded(
            child: fileState.when(
              data: (files) => FileList(files: files),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Error: ${error.toString()}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}