import 'package:flutter/material.dart';

class ViewImages extends StatelessWidget {
  final List imagesList =[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: imagesList.length,
          itemBuilder: (context, i) {
            return Image.asset("name");
        }),
      ),
    );
  }
}
