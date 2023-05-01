import 'dart:developer';

import 'package:assignment_app/widgets/custom_btn.dart';
import 'package:assignment_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../constants/app_constants.dart';
import '../constants/color_constants.dart';
import '../providers/auth_provider.dart';
import '../widgets/loading_view.dart';
import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController nameControoler = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
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
          AppConstants.signUpTitle,
          style: TextStyle(color: ColorConstants.primaryColor),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  authProvider.status == Status.authenticating
                      ? const LoadingView()
                      : const SizedBox.shrink(),
                  CustomTextField(
                      hintText: 'Enter Full Name', controller: nameControoler),
                  AppConstants.kHeight10,
                  CustomTextField(
                      keyBoardType: TextInputType.number,
                      hintText: 'Enter Your Phone Number',
                      controller: phoneNumberController),
                  AppConstants.kHeight10,
                  CustomTextField(
                      hintText: 'Enter Your Email Address',
                      controller: emailController),
                  AppConstants.kHeight10,
                  CustomTextField(
                      hintText: 'Enter Your Passoword',
                      controller: passWordController),
                  AppConstants.kHeight15,
                  SizedBox(
                    height: 50,
                    width: size.width / 1.15,
                    child: CustomButton(
                      text: 'Sign Up',
                      textSize: 18,
                      onPress: () {
                        if (formkey.currentState!.validate()) {
                          authProvider
                              .sigUpWithEmailAndPassword(
                            emailController.text,
                            passWordController.text,
                            phoneNumberController.text,
                            nameControoler.text,
                          )
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
                            log('sign up error ${error.toString()}');
                            authProvider.handleException();
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
