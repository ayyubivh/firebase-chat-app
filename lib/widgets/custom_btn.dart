import 'package:assignment_app/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double textSize;
  final VoidCallback onPress;
  final Color color;
  final Widget? loader;

  const CustomButton({
    Key? key,
    required this.text,
    required this.textSize,
    required this.onPress,
    this.color = ColorConstants.primaryColor,
    this.loader,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: color,
      ),
      onPressed: onPress,
      child: loader ??
          Text(
            text,
            style: TextStyle(
              fontSize: textSize,
              color: ColorConstants.greyColor2,
            ),
          ),
    );
  }
}
