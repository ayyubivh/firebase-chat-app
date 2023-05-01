import 'package:assignment_app/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyBoardType;
  final String? errText;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.errText,
    required this.controller,
    this.keyBoardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyBoardType,
      controller: controller,
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConstants.themeColor),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorConstants.themeColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        errorText: errText,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 16,
          color: ColorConstants.greyColor,
          fontWeight: FontWeight.w400,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorConstants.themeColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please enter your $hintText';
        }
      },
    );
  }
}
