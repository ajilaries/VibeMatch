import '../../models/snap_model.dart';

class SnapStorage {
  static List<SnapModel> snaps = [];

  /// 🔥 Add new snap (latest first)
  static void addSnap(SnapModel snap) {
    snaps.insert(0, snap);
  }

  /// 🔥 Get all snaps
  static List<SnapModel> getSnaps() {
    return snaps;
  }
}