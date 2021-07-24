import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:aws_auth/screens/components/loading.dart';
import 'package:flutter/material.dart';

class ViewImages extends StatefulWidget {
  @override
  _ViewImagesState createState() => _ViewImagesState();
}

class _ViewImagesState extends State<ViewImages> {
  List<GetUrlResult> imagesList = [];
  bool isLoading = false;

  Future<List<GetUrlResult>> getImages() async {
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
    getImages().then((value) {
      setState(() {
        imagesList = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Loading()
          : imagesList.isEmpty?
          Center(child: Text("No Images found",style: TextStyle(color: Colors.red,fontSize: 30),),)
          : Container(
              padding: EdgeInsets.all(20),
              child: SafeArea(
                child: ListView.builder(
                    itemCount: imagesList.length,
                    itemBuilder: (context, i) {
                      return Container(
                          height: 300,
                          width: 300,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.amber)
                          ),
                          child: Image.network(
                            imagesList[i].url,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ));
                    }),
              ),
            ),
    );
  }
}
