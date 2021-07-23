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
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Text(
                          "Create an Account",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        // padding: EdgeInsets.symmetric(vertical: 20),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              fillColor: Colors.grey[850],
                              filled: true,
                              focusColor: Colors.black26,
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(),
                              hintText: "Username"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        // padding: EdgeInsets.symmetric(vertical: 20),

                        child: TextFormField(
                          controller: emailCont,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              fillColor: Colors.grey[850],
                              filled: true,
                              focusColor: Colors.black26,
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(),
                              hintText: "Email Address"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        // padding: EdgeInsets.symmetric(vertical: 20),
                        child: TextField(
                          obscureText: true,
                          controller: passCont,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: Colors.grey[850],
                            filled: true,
                            focusColor: Colors.black26,
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(),
                            hintText: "Password",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
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
                      Visibility(
                        visible: _isSignedUp,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: confirmController,
                              style: TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                fillColor: Colors.black38,
                                filled: true,
                                focusColor: Colors.black26,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.amber, width: 2.0),
                                ),
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: 'The code we sent you',
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
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
                                await authAWSRepo.signIn(emailCont.text.trim(),
                                    passCont.text.trim());
                                setState(() {
                                  _isLoading = false;
                                });
                              },
                              child: const Text(
                                'Confirm Sign Up',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have account? ",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              },
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                    fontSize: 15, color: kDefaultcolor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
