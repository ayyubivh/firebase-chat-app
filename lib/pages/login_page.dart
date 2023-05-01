import 'dart:developer';

import 'package:assignment_app/pages/signup_page.dart';
import 'package:assignment_app/widgets/custom_btn.dart';
import 'package:assignment_app/widgets/custom_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../constants/app_constants.dart';
import '../constants/color_constants.dart';
import '../providers/auth_provider.dart';
import '../widgets/widgets.dart';
import 'pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    switch (authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: "Sign in fail");
        break;
      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: "Sign in canceled");
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: "Sign in success");
        break;
      default:
        break;
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            AppConstants.loginTitle,
            style: TextStyle(color: ColorConstants.primaryColor),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            authProvider.status == Status.authenticating
                ? const LoadingView()
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: emailController,
                      hintText: 'Enter Your Email Address',
                    ),
                    AppConstants.kHeight10,
                    CustomTextField(
                      controller: passWordController,
                      hintText: 'Enter Your Password',
                    ),
                    AppConstants.kHeight15,
                    SizedBox(
                      height: 50,
                      width: size.width / 1.15,
                      child: CustomButton(
                        text: 'Sign In',
                        textSize: 18,
                        onPress: () {
                          if (formkey.currentState!.validate()) {
                            authProvider
                                .sigInWithEmailAndPassword(emailController.text,
                                    passWordController.text)
                                .then((isSuccess) {
                              if (isSuccess) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                );
                              }
                            }).catchError((error, stackTrace) {
                              Fluttertoast.showToast(msg: error.toString());
                              log('login error ${error.toString()}');
                              authProvider.handleException();
                            });
                          }
                        },
                      ),
                    ),
                    AppConstants.kHeight15,
                    const Text('OR',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    AppConstants.kHeight15,
                    TextButton(
                      onPressed: () async {
                        authProvider.handleSignIn().then((isSuccess) {
                          if (isSuccess) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          }
                        }).catchError((error, stackTrace) {
                          Fluttertoast.showToast(msg: error.toString());
                          authProvider.handleException();
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return const Color(0xffdd4b39).withOpacity(0.8);
                            }
                            return const Color(0xffdd4b39);
                          },
                        ),
                        splashFactory: NoSplash.splashFactory,
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.fromLTRB(30, 15, 30, 15),
                        ),
                      ),
                      child: const Text(
                        'Sign in with Google',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    AppConstants.kHeight15,
                    Text.rich(
                      TextSpan(
                        text: "Dont't hava an account ? ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        children: [
                          TextSpan(
                              style: const TextStyle(
                                color: ColorConstants.themeColor,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              text: "Sign Up here",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const SignUpPage(),
                                  ));
                                })
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Loading
          ],
        ));
  }
}
