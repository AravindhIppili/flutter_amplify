import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:aws_auth/screens/components/loading.dart';
import 'package:aws_auth/screens/components/video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ViewVideos extends StatefulWidget {
  @override
  _ViewVideosState createState() => _ViewVideosState();
}

class _ViewVideosState extends State<ViewVideos> {
  List<GetUrlResult> videosList = [];
  bool isLoading = false;

  Future<List<GetUrlResult>> getVideos() async {
    setState(() {
      isLoading = true;
    });
    final result = await Amplify.Storage.list();
    List<GetUrlResult> urls = [];
    for (var i = 0; i < result.items.length; i++) {
      await Amplify.Storage.getUrl(key: result.items[i].key)
          .then((value) => urls.add(value));
    }
    return urls;
  }

  @override
  void initState() {
    super.initState();
    getVideos().then((value) {
      setState(() {
        videosList = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Loading()
          : videosList.isEmpty
              ? Center(
                  child: Text(
                    "No Images found",
                    style: TextStyle(color: Colors.red, fontSize: 30),
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(20),
                  child: SafeArea(
                    child: ListView.builder(
                        itemCount: videosList.length,
                        itemBuilder: (context, i) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: CustomVideoPlayer(
                                viskey: "key+$i",
                                videoPlayerController:
                                    VideoPlayerController.network(
                                  videosList[i].url,
                                )..initialize()),
                          );
                          // Image.network(
                          //   videosList[i].url,
                          //   loadingBuilder: (context, child, loadingProgress) {
                          //     if (loadingProgress == null) return child;
                          //     return Center(
                          //       child: CircularProgressIndicator(),
                          //     );
                          //   },
                          // ));
                        }),
                  ),
                ),
    );
  }
}
