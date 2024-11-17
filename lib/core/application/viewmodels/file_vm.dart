import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:windrop/core/domain/entities/file_model.dart';
import 'package:windrop/core/infrastructure/repositories/file_repository.dart';

final fileRepositoryProvider = Provider((ref) => FileRepository());

final fileViewModelProvider = StateNotifierProvider<FileViewModel, AsyncValue<List<FileModel>>>(
  (ref) => FileViewModel(ref.watch(fileRepositoryProvider)),
);

class FileViewModel extends StateNotifier<AsyncValue<List<FileModel>>> {
  final FileRepository _repository;
  
  FileViewModel(this._repository) : super(const AsyncValue.data([]));

  Future<void> uploadFile(File file) async {
    try {
      state = const AsyncValue.loading();
      final uploadedFile = await _repository.uploadFile(file);
      state = AsyncValue.data([...state.value ?? [], uploadedFile]);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<String?> downloadFile(String fileId, String filename) async {
    try {
      final savePath = await _getDownloadPath(filename);
      return await _repository.downloadFile(fileId, savePath);
    } catch (error) {
      return null;
    }
  }

  Future<String> _getDownloadPath(String filename) async {
    final dir = Directory.systemTemp;
    return '${dir.path}/$filename';
  }
}