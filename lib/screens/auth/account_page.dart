import 'package:emg/screens/auth/login/login_page.dart';
import 'package:emg/screens/auth/signup/signup_page.dart';
import 'package:emg/utils/buttons.dart';
import 'package:emg/utils/colors.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/backimage.png"), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 220,
            ),
            Align(
                alignment: Alignment.center,
                // margin: EdgeInsets.only(top: 200),
                child: OutlineButton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => const LoginPage()));
                    },
                    title: "Report Emergency")),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "OR",
              style:
                  TextStyle(color: offRedButton, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            SaveButton(
                title: "Sign Up",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const SignUpPage()));
                })
          ],
        ),
      ),
    );
  }
}
