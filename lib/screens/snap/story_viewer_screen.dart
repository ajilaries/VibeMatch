import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../models/snap_model.dart';
import '../../core/services/api_service.dart';
import '../../core/utils/token_storage.dart';

class StoryViewerScreen extends StatefulWidget {
  final List<SnapModel> snaps;
  final int initialIndex;

  const StoryViewerScreen({
    super.key,
    required this.snaps,
    required this.initialIndex,
  });

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends State<StoryViewerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController progressController;
  late int currentIndex;
  Timer? timer;
  VideoPlayerController? videoController;

  // ✅ prevent duplicate view calls
  final Set<String> viewedSnapIds = {};

  @override
  void initState() {
    super.initState();
    progressController = AnimationController(vsync: this);
    currentIndex = widget.initialIndex;
    loadSnap();
  }

  // 👀 MARK AS VIEWED
  void markAsViewed() async {
    final snapId = widget.snaps[currentIndex].id;

    // duplicate calls
    if (viewedSnapIds.contains(snapId)) return;

    viewedSnapIds.add(snapId);

    try {
      final token = await TokenStorage.getToken();
      if (token == null) return;

      await ApiService.markSnapViewed(snapId: snapId, token: token);
    } catch (e) {
      debugPrint("View tracking error: $e");
    }
  }

  void loadSnap() {
    timer?.cancel();
    videoController?.dispose();
    progressController.stop();
    progressController.reset();

    final snap = widget.snaps[currentIndex];

    if (snap.type == "video") {
      videoController = VideoPlayerController.file(File(snap.imagePath))
        ..initialize().then((_) {
          if (!mounted) return;

          setState(() {});
          videoController!.play();

          final duration = videoController!.value.duration;

          progressController.duration = duration;
          progressController.forward();

          timer = Timer(duration, nextSnap);
        });
    } else {
      final duration = Duration(seconds: snap.viewDuration);

      progressController.duration = duration;
      progressController.forward();

      timer = Timer(duration, nextSnap);
    }

    if (mounted) setState(() {});

    void simulateViews() {
      final snap = widget.snaps[currentIndex];

      // Only simulate for your own snaps
      if (snap.username != "You") return;

      // Avoid duplicate simulation
      if (snap.viewedBy.isNotEmpty) return;

      // Fake viewers
      snap.viewedBy.addAll([
        {"username": "Rahul", "time": "2m ago"},
        {"username": "Anu", "time": "5m ago"},
        {"username": "Kiran", "time": "10m ago"},
      ]);
    }

    simulateViews();
  }

  void nextSnap() {
    final snap = widget.snaps[currentIndex];

    // 🔥 mark as opened
    snap.isOpened = true;

    if (currentIndex < widget.snaps.length - 1) {
      setState(() {
        currentIndex++;
      });
      loadSnap();
    } else {
      Navigator.pop(context);
    }
  }

  void previousSnap() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
      loadSnap();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    videoController?.dispose();
    progressController.dispose();
    super.dispose();
  }

  void openReplySheet() {
    TextEditingController controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 10,
            right: 10,
            top: 10,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Type your reply...",
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: () {
                  if (controller.text.trim().isNotEmpty) {
                    sendReply(controller.text.trim());
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void sendReply(String message) {
    final snap = widget.snaps[currentIndex];

    // For now just print (frontend stage)
    print("Reply to ${snap.username}: $message");

    // Later we send this to chat screen
  }

  @override
  Widget build(BuildContext context) {
    final snap = widget.snaps[currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapUp: (details) {
          final screenWidth = MediaQuery.of(context).size.width;

          if (details.globalPosition.dx < screenWidth / 2) {
            previousSnap();
          } else {
            nextSnap();
          }
        },
        child: Stack(
          children: [
            /// 📸 IMAGE / 🎥 VIDEO
            Center(
              child: snap.type == "video"
                  ? (videoController != null &&
                            videoController!.value.isInitialized)
                        ? AspectRatio(
                            aspectRatio: videoController!.value.aspectRatio,
                            child: VideoPlayer(videoController!),
                          )
                        : const CircularProgressIndicator()
                  : Image.file(
                      File(snap.imagePath),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
            ),

            /// 📊 PROGRESS BAR
            Positioned(
              top: 40,
              left: 10,
              right: 10,
              child: Row(
                children: List.generate(widget.snaps.length, (index) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: 3,
                      child: Stack(
                        children: [
                          Container(color: Colors.white38),

                          if (index < currentIndex)
                            Container(color: Colors.white),

                          if (index == currentIndex)
                            AnimatedBuilder(
                              animation: progressController,
                              builder: (context, child) {
                                return FractionallySizedBox(
                                  widthFactor: progressController.value,
                                  child: Container(color: Colors.white),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),

            /// ❌ CLOSE
            Positioned(
              top: 45,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            /// 👤 USERNAME
            Positioned(
              top: 50,
              left: 60,
              child: Text(
                snap.username,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  openReplySheet();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Text(
                    "Send a reply",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
