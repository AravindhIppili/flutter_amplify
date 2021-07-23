import 'package:aws_auth/const.dart';
import 'package:aws_auth/provider.dart';
import 'package:aws_auth/screens/components/loading.dart';
import 'package:aws_auth/screens/sign_up.dart';
import 'package:aws_auth/services/auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Stack(
                children: [
                  Column(children: [
                    SizedBox(height: 30),
                    Container(
                      child: Text(
                        "Login Now",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      child: Text(
                        "Welcome back to PlayZone! Enter your email address and your password to enjoy the latest features of PlayZone",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: TextFormField(
                        controller: emailCont,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Email Address"),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: TextField(
                        obscureText: true,
                        controller: passCont,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Password",
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          final authAWSRepo =
                              context.read(authAWSRepositoryProvider);
                          await authAWSRepo.signIn(
                              emailCont.text.trim(), passCont.text.trim());
                          context.refresh(authUserProvider);
                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.black, fontSize: kDefFontSize),
                            )),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amber),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text(
                            "Sign in with Google",
                            style: TextStyle(
                                color: Colors.black, fontSize: kDefFontSize),
                          )),
                    )
                  ]),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Text(
                              "Don't have account? ",
                              style: TextStyle(fontSize: kDefFontSize),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUp()));
                                },
                                child: Text("Create one",
                                    style: TextStyle(
                                        fontSize: kDefFontSize,
                                        color: kDefaultcolor)))
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ));
  }
}
