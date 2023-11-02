import 'package:dots_indicator/dots_indicator.dart';
import 'package:emg/screens/introscreens/screensone.dart';
import 'package:emg/screens/introscreens/screensthree.dart';
import 'package:emg/screens/introscreens/screenstwo.dart';
import 'package:flutter/material.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({super.key});

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

int currentPage = 0;

final _controller = PageController(initialPage: 0);
List<Widget> _pages = const [
  OnboardingScreenOne(),
  OnboardingScreenTwo(),
  OnboardingScreenThree(),
];

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                children: _pages,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: DotsIndicator(
                dotsCount: _pages.length,
                position: currentPage,
                decorator: const DotsDecorator(
                  color: Colors.black87, // Inactive color
                  activeColor: Colors.redAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
