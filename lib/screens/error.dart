import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            "An error occured!",
            style: TextStyle(
              color: Colors.red
            ),
          ),
        ),
      ),
    );
  }
}