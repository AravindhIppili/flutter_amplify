import 'dart:io';

import 'package:aws_auth/const.dart';
import 'package:aws_auth/provider.dart';
import 'package:aws_auth/screens/components/loading.dart';
import 'package:aws_auth/screens/view_images.dart';
import 'package:aws_auth/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class HomeVideo extends StatefulWidget {
  const HomeVideo({Key? key}) : super(key: key);

  @override
  _HomeVideoState createState() => _HomeVideoState();
}

class _HomeVideoState extends State<HomeVideo> {
  bool _isLoading = false;
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
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
                    ))
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        "PlayZone",
                        style: TextStyle(fontSize: kDefFontSize),
                      ),
                    ),
                    if (image != null)
                      Image.file(File(image!.path))
                    else
                      Text(""),
                    Container(
                        child: TextButton(
                            onPressed: () async {
                              final ImagePicker _picker = ImagePicker();
                              final XFile? img = await _picker.pickImage(
                                  source: ImageSource.gallery,
                                  imageQuality: 100,
                                  maxHeight:
                                      MediaQuery.of(context).size.height / 2);
                              setState(() {
                                image = img;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                "Select Image",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: kDefFontSize),
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.amber),
                            ))),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        child: TextButton(
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewImages()));
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                "View Images",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: kDefFontSize),
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.amber),
                            ))),
                    Container(
                      child: Text(
                        "Latest Feature in Streaming Your Favourite Channel",
                        style: TextStyle(fontSize: kDefFontSize),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
