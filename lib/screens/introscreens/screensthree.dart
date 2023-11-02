import 'package:emg/screens/auth/account_page.dart';
import 'package:emg/utils/colors.dart';
import 'package:flutter/material.dart';

class OnboardingScreenThree extends StatefulWidget {
  const OnboardingScreenThree({super.key});

  @override
  State<OnboardingScreenThree> createState() => _OnboardingScreenThreeState();
}

class _OnboardingScreenThreeState extends State<OnboardingScreenThree> {
  @override
  Widget build(BuildContext context) {
    //it will helps to return the size of the screen
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (builder) => const AccountPage()));
      },
      child: Stack(
        children: [
          Image.asset(
            "assets/fire.png",
            height: 800,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.only(top: 160),
              child: const Text(
                "Fire fighters squads\n are up for rescue \n mission",
                style: TextStyle(color: colorGrey, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
