import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  CustomVideoPlayer({Key? key, required this.videoPlayerController})
      : super(key: key);
  final VideoPlayerController videoPlayerController;

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager =
        FlickManager(videoPlayerController: widget.videoPlayerController,autoPlay: false);
  }

  @override
  void dispose() {
    super.dispose();
    flickManager.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height / 2),
        padding: EdgeInsets.all(3),
        color: Colors.amber,
        child: FlickVideoPlayer(
            flickManager: flickManager,
            flickVideoWithControls: FlickVideoWithControls(
              playerLoadingFallback: Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              )),
              willVideoPlayerControllerChange: false,
              controls: FlickPortraitControls(),
            )),
      ),
    );
  }
}
