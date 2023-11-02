import 'package:emg/utils/colors.dart';
import 'package:flutter/material.dart';

class HealthCareIconWidget extends StatelessWidget {
  const HealthCareIconWidget({super.key, this.height, this.width});

  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 70,
      height: height ?? 50,
      padding:
          width != null ? const EdgeInsets.all(6) : const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: offRedButton,
      ),
      child: Image.asset(
        "assets/heart-icon.png",
        color: colorWhite,
      ),
    );
  }
}
