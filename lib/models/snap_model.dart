class SnapModel {
  final String imagePath;
  final String username;
  final DateTime timestamp;
  final String type;//image or video

  SnapModel({
    required this.imagePath,
    required this.username,
    required this.timestamp,
    required this.type,
  });
}
