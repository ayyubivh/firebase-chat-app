import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0),
      child: Container(
        color: Colors.white.withOpacity(0.8),
        child: const CircularProgressIndicator(
          color: ColorConstants.themeColor,
        ),
      ),
    );
  }
}
