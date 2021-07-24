import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:aws_auth/amplifyconfiguration.dart';
import 'package:aws_auth/provider.dart';
import 'package:aws_auth/screens/components/loading.dart';
import 'package:aws_auth/screens/error.dart';
import 'package:aws_auth/screens/home.dart';
import 'package:aws_auth/screens/home_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _amplifyConfigured = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    await Amplify.addPlugins([AmplifyAuthCognito(), AmplifyStorageS3()]);
    await Amplify.configure(amplifyconfig);
    setState(() {
      _amplifyConfigured = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AWS',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          scaffoldBackgroundColor: Colors.black45,
        ),
        home: _amplifyConfigured
            ? Consumer(builder: (context, watch, child) {
                final currentUser = watch(authUserProvider);
                return currentUser.when(data: (data) {
                  if (data.isEmpty) {
                    return HomePage();
                  }
                  return HomeVideo();
                }, loading: () {
                  return const Loading();
                }, error: (e, st) {
                  return const ErrorPage();
                });
              })
            : CircularProgressIndicator(),
      ),
    );
  }
}
