import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../models/snap_model.dart';

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

class _StoryViewerScreenState extends State<StoryViewerScreen> {
  late int currentIndex;
  Timer? timer;

  VideoPlayerController? videoController;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    loadSnap(); // 🔥 IMPORTANT
  }

  void loadSnap() {
    timer?.cancel();
    videoController?.dispose();

    final snap = widget.snaps[currentIndex];

    if (snap.type == "video") {
      videoController = VideoPlayerController.file(File(snap.imagePath))
        ..initialize().then((_) {
          setState(() {});
          videoController!.play();

          // ⏱️ Auto next after video ends
          timer = Timer(videoController!.value.duration, nextSnap);
        });
    } else {
      // ⏱️ Image auto next (5 sec)
      timer = Timer(const Duration(seconds: 5), nextSnap);
    }

    setState(() {});
  }

  void nextSnap() {
    if (currentIndex < widget.snaps.length - 1) {
      setState(() {
        currentIndex++;
      });
      loadSnap(); // 🔥 reload
    } else {
      Navigator.pop(context); // ❌ auto close
    }
  }

  void previousSnap() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
      loadSnap(); // 🔥 reload
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    videoController?.dispose();
    super.dispose();
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
                          aspectRatio:
                              videoController!.value.aspectRatio,
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
                      color: index <= currentIndex
                          ? Colors.white
                          : Colors.white38,
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
          ],
        ),
      ),
    );
  }
}