import 'package:aws_auth/const.dart';
import 'package:aws_auth/provider.dart';
import 'package:aws_auth/screens/components/loading.dart';
import 'package:aws_auth/screens/home.dart';
import 'package:aws_auth/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  bool _isSignedUp = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loading()
        : Scaffold(
            body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Stack(
                children: [
                  Column(children: [
                    Container(
                      child: Text(
                        "Create an Account",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: "Username"),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        controller: emailCont,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Email Address"),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: TextField(
                        obscureText: true,
                        controller: passCont,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Password",
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          final authAWSRepo =
                              context.read(authAWSRepositoryProvider);
                          await authAWSRepo.signUp(
                              emailCont.text.trim(), passCont.text.trim());
                          context.refresh(authUserProvider);
                          setState(() {
                            _isLoading = false;
                            _isSignedUp = true;
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text(
                              "Create Account",
                              style: TextStyle(
                                  color: Colors.black, fontSize: kDefFontSize),
                            )),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amber),
                        )),
                    Visibility(
                        visible: _isSignedUp,
                        child: Column(children: [
                          TextFormField(
                              controller: confirmController,
                              decoration: const InputDecoration(
                                hintText: 'The code we sent you',
                              )),
                          ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              final authAWSRepo =
                                  context.read(authAWSRepositoryProvider);
                              await authAWSRepo.confirmSignUp(
                                  emailCont.text.trim(),
                                  confirmController.text.trim());
                              context.refresh(authUserProvider);
                              await authAWSRepo.signIn(
                                  emailCont.text.trim(), passCont.text.trim());
                              setState(() {
                                _isLoading = false;
                              });
                            },
                            child: const Text('Confirm Sign Up'),
                          ),
                        ])),
                  ]),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Text(
                              "Already have account? ",
                              style: TextStyle(fontSize: kDefFontSize),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                },
                                child: Text("Sign in",
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
