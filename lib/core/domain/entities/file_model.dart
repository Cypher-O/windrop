class FileModel {
  final String id;
  final String filename;
  final int size;

  FileModel({
    required this.id,
    required this.filename,
    required this.size,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      id: json['id'],
      filename: json['filename'],
      size: json['size'],
    );
  }
}