import 'package:aws_auth/const.dart';
import 'package:aws_auth/provider.dart';
import 'package:aws_auth/screens/components/loading.dart';
import 'package:aws_auth/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeVideo extends StatefulWidget {
  const HomeVideo({Key? key}) : super(key: key);

  @override
  _HomeVideoState createState() => _HomeVideoState();
}

class _HomeVideoState extends State<HomeVideo> {
  bool _isLoading = false;
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
            body: Container(
              child: Column(
                children: [
                  Container(
                    child: Text("PlayZone"),
                  ),
                  Container(),
                  Container(
                    child: Text(
                      "Latest Feature in Streaming Your Favourite Channel",
                      style: TextStyle(fontSize: kDefFontSize),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
