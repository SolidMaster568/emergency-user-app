import 'package:emg/utils/colors.dart';
import 'package:flutter/material.dart';

class OnboardingScreenOne extends StatefulWidget {
  const OnboardingScreenOne({super.key});

  @override
  State<OnboardingScreenOne> createState() => _OnboardingScreenOneState();
}

class _OnboardingScreenOneState extends State<OnboardingScreenOne> {
  @override
  Widget build(BuildContext context) {
    //it will helps to return the size of the screen
    return Stack(
      children: [
        Image.asset(
          "assets/health.png",
          height: 800,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 30, top: 100),
            child: const Text(
              "Swift health\n care response",
              style: TextStyle(color: colorGrey, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
