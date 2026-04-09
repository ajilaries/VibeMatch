class SnapModel {
  final String id;
  final String imagePath;
  final String username;
  final DateTime timestamp;
  final String type;

  final int viewDuration;
  final List<dynamic> viewedBy;

  // 🔥 NEW
  bool isOpened;
  bool canReplay;

  SnapModel({
    required this.id,
    required this.imagePath,
    required this.username,
    required this.timestamp,
    required this.type,
    this.viewDuration = 5,
    this.viewedBy = const [],
    this.isOpened = false,
    this.canReplay = true,
  });
}