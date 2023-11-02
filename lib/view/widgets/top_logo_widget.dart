import 'package:flutter/material.dart';

class TopLogoWidget extends StatelessWidget {
  const TopLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * 0.16,),
        Container(
          width: size.width * 0.25, height: size.height * 0.16,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/logo.png")
            ),
          ),
        ),
        SizedBox(height: size.height * 0.1,),
      ],
    );
  }
}
