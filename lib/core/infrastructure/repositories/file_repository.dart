import 'dart:io';
import 'package:dio/dio.dart';
import 'package:windrop/core/domain/entities/file_model.dart';
import 'package:windrop/core/utils/constants.dart';

class FileRepository {
  final Dio _dio;

  FileRepository() : _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  Future<FileModel> uploadFile(File file) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    });

    final response = await _dio.post(
      ApiConstants.uploadEndpoint,
      data: formData,
    );

    if (response.data['code'] == 0) {
      return FileModel.fromJson(response.data['data']);
    }
    throw Exception(response.data['message']);
  }

  Future<String> downloadFile(String fileId, String savePath) async {
    final response = await _dio.get(
      '${ApiConstants.filesEndpoint}/$fileId',
      options: Options(responseType: ResponseType.bytes),
    );

    final file = File(savePath);
    await file.writeAsBytes(response.data);
    return file.path;
  }
}