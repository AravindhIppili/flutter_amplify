import 'dart:io';

import 'package:aws_auth/const.dart';
import 'package:aws_auth/provider.dart';
import 'package:aws_auth/screens/components/loading.dart';
import 'package:aws_auth/screens/view_videos.dart';
import 'package:aws_auth/services/auth.dart';
import 'package:aws_auth/services/upload_file.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:video_player/video_player.dart';

class HomeVideo extends StatefulWidget {
  const HomeVideo({Key? key}) : super(key: key);

  @override
  _HomeVideoState createState() => _HomeVideoState();
}

class _HomeVideoState extends State<HomeVideo> {
  bool _isLoading = false;
  XFile? video;
  VideoPlayerController? videoPlayerController;
  late FlickManager flickManager;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                TextButton(
                  onPressed: () async {
                    try {
                      setState(() {
                        _isLoading = true;
                      });
                      final authAWSRepo =
                          context.read(authAWSRepositoryProvider);
                      await authAWSRepo.logOut();
                      context.refresh(authUserProvider);
                      setState(() {
                        _isLoading = false;
                      });
                    } catch (e) {}
                  },
                  child: Text(
                    "Logout",
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      child: GradientText(
                        "PlayZone",
                        colors: [
                          Color(0xFF303030),
                          Colors.white,
                        ],
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    if (video != null)
                      if (videoPlayerController!.value.isInitialized)
                        AspectRatio(
                          aspectRatio:
                              videoPlayerController!.value.aspectRatio,
                          child: Container(
                            constraints: BoxConstraints(
                                minHeight:
                                    MediaQuery.of(context).size.height / 2),
                            padding: EdgeInsets.all(3),
                            color: Colors.amber,
                            child: FlickVideoPlayer(
                              flickManager: flickManager,
                            ),
                          ),
                        ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: TextButton(
                              onPressed: () async {
                                final ImagePicker _picker = ImagePicker();
                                final XFile? vid = await _picker.pickVideo(
                                    source: ImageSource.gallery,
                                    maxDuration: Duration(minutes: 2));
                                video = vid;
                                videoPlayerController = VideoPlayerController
                                    .file(File(video!.path))
                                  ..initialize().then((value) {
                                    flickManager = FlickManager(videoPlayerController: videoPlayerController!);
                                    setState(() {});
                                  });
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                child: Text(
                                  "Select Video",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: kDefFontSize),
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.amber),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            child: TextButton(
                              onPressed: () async {
                                if (video != null) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await Storage().uploadFile(File(video!.path));
                                  setState(() {
                                    video = null;
                                    _isLoading = false;
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                child: Text(
                                  "Upload Video",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: kDefFontSize),
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.amber),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: TextButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewVideos(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            "View Videos",
                            style: TextStyle(
                                color: Colors.black, fontSize: kDefFontSize),
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amber),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Text(
                          "Latest Feature in Streaming Your Favourite Channel",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
