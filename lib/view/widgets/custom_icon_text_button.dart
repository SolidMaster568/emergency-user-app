import 'package:emg/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomIconTextButton extends StatelessWidget {
  final Color iconColor;
  final String label;
  final IconData iconData;

  const CustomIconTextButton(
      {super.key,
      required this.iconColor,
      required this.label,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: colorWhite,
          ),
          child: Icon(
            iconData,
            color: iconColor,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(label),
      ],
    );
  }
}
