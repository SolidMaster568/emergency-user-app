import 'package:emg/utils/colors.dart';
import 'package:flutter/material.dart';

class OnboardingScreenTwo extends StatefulWidget {
  const OnboardingScreenTwo({super.key});

  @override
  State<OnboardingScreenTwo> createState() => _OnboardingScreenTwoState();
}

class _OnboardingScreenTwoState extends State<OnboardingScreenTwo> {
  @override
  Widget build(BuildContext context) {
    //it will helps to return the size of the screen
    return Stack(
      children: [
        Image.asset(
          "assets/security.png",
          height: 800,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.only(right: 30, top: 100),
            child: const Text(
              "Security teams\n are just a \n click away",
              style: TextStyle(color: colorGrey, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
