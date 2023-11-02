import 'dart:async';

import 'package:emg/models/user_model.dart';
import 'package:emg/screens/dashboard/main_dashboard.dart';
import 'package:emg/screens/introscreens/onboard.dart';
import 'package:emg/utils/globals.dart';
import 'package:emg/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SpalshPage extends StatefulWidget {
  const SpalshPage({super.key});

  @override
  State<SpalshPage> createState() => _SpalshPageState();
}

class _SpalshPageState extends State<SpalshPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      autoLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/videocall.png"),
      ),
    );
  }

  Future<void> autoLogin() async {
    if (FirebaseAuth.instance.currentUser == null) {
      Timer.periodic(const Duration(seconds: 3), (timer) {
        timer.cancel();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const OnBoardingScreens(),
          ),
        );
      });
    } else {
      User user = FirebaseAuth.instance.currentUser!;
      try {
        UserModel? userModel = await Util.getUserByFirebase(user.uid);

        if (userModel != null) {
          Globals.currentUser = userModel;
          Util.updateDeviceToken();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (builder) => const MainScreen(),
            ),
          );
        } else {
          await FirebaseAuth.instance.signOut();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const OnBoardingScreens(),
            ),
          );
        }
      } catch (e) {
        print(e);

        await FirebaseAuth.instance.signOut();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const OnBoardingScreens(),
          ),
        );
      }
    }
  }
}
