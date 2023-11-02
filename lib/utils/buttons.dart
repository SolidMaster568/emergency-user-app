import 'package:emg/utils/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SaveButton extends StatelessWidget {
  String title;
  final void Function()? onTap;
  final ButtonStyle? style;

  SaveButton({super.key, required this.title, required this.onTap, this.style});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: style,
      child: Text(
        title,
        style: const TextStyle(
            fontFamily: "Mulish",
            fontWeight: FontWeight.w400,
            color: Colors.white),
      ),
    );
  }
}

class OutlineButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final ButtonStyle? style;

  const OutlineButton(
      {super.key, required this.title, required this.onTap, this.style});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: style,
      child: Text(
        title,
        style: const TextStyle(
            fontFamily: "Mulish",
            fontWeight: FontWeight.w600,
            color: colorGrey),
      ),
    );
  }
}
