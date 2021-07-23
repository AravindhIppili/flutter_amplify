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
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 30),
                        Container(
                          child: Text(
                            "Login Now",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          child: Text(
                            "Welcome back to PlayZone! Enter your email address and your password to enjoy the latest features of PlayZone",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          child: TextFormField(
                            controller: emailCont,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: Colors.grey[850],
                              filled: true,
                              focusColor: Colors.black26,
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Email Address",
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: TextField(
                            obscureText: true,
                            controller: passCont,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                fillColor: Colors.grey[850],
                                filled: true,
                                focusColor: Colors.black26,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                        SizedBox(height: 50),
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
                              "Login Now",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.amber),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.grey
                              ),
                              borderRadius: BorderRadius.circular(5)
                            )
                          ),
                          onPressed: () {},
                          child: Container(
                            margin: EdgeInsets.zero,
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            child: Text(
                              "Sign in with Google",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have account? ",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()));
                              },
                              child: Text(
                                "Create one",
                                style: TextStyle(
                                    fontSize: 15, color: kDefaultcolor),
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          );
  }
}
