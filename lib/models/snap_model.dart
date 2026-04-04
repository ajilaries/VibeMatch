class SnapModel {
  final String id;
  final String imagePath;
  final String username;
  final DateTime timestamp;
  final String type; // image or video

  // ✅ ADD THIS
  final int viewDuration;

  // ✅ (for later use - seen count)
  final List<dynamic> viewedBy;

  SnapModel({
    required this.id,
    required this.imagePath,
    required this.username,
    required this.timestamp,
    required this.type,
    this.viewDuration = 5, // default 5 sec
    this.viewedBy = const [],
  });
}