import 'dart:io';

import 'package:aws_auth/const.dart';
import 'package:aws_auth/provider.dart';
import 'package:aws_auth/screens/components/loading.dart';
import 'package:aws_auth/screens/view_images.dart';
import 'package:aws_auth/services/auth.dart';
import 'package:aws_auth/services/upload_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

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
                    if (image != null)
                      Container(
                        padding: EdgeInsets.all(3),
                        color: Colors.amber,
                        child: Image.file(
                          File(image!.path),
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
                                if (image != null) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await Storage().uploadFile(File(image!.path));
                                  setState(() {
                                    image = null;
                                    _isLoading = false;
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                child: Text(
                                  "Upload Image",
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
                              builder: (context) => ViewImages(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            "View Images",
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
