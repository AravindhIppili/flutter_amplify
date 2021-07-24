import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CustomVideoPlayer extends StatelessWidget {
  final String viskey;
  CustomVideoPlayer({required this.viskey,Key? key, required this.videoPlayerController})
      : super(key: key);
  final VideoPlayerController? videoPlayerController;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: VisibilityDetector(
        onVisibilityChanged: (VisibilityInfo info) {
          if (info.visibleFraction == 0) {
            videoPlayerController!.pause();
          }
        },
        key: Key(viskey),
        child: GestureDetector(
          onTap: () {
            videoPlayerController!.value.isPlaying
                ? videoPlayerController!.pause()
                : videoPlayerController!.play();
          },
          child: AspectRatio(
            aspectRatio: videoPlayerController!.value.aspectRatio,
            child: Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height / 2),
              padding: EdgeInsets.all(3),
              color: Colors.amber,
              child: VideoPlayer(videoPlayerController!),
            ),
          ),
        ),
      ),
    );
  }
}
