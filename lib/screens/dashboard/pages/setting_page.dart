import 'package:cached_network_image/cached_network_image.dart';
import 'package:emg/screens/auth/login/login_page.dart';
import 'package:emg/utils/buttons.dart';
import 'package:emg/utils/colors.dart';
import 'package:emg/utils/globals.dart';
import 'package:emg/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Center(
          child: CachedNetworkImage(
            imageUrl: Globals.currentUser!.photourl,
            imageBuilder: ((context, imageProvider) => CircleAvatar(
                  radius: 60,
                  backgroundImage: imageProvider,
                )),
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                const CircleAvatar(radius: 60),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          Globals.currentUser!.firstname,
          style: const TextStyle(
              color: colorBlack, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const Divider(color: colorGrey),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person,
                color: buttonColor,
              ),
              Text(
                Globals.currentUser!.firstname,
                style: const TextStyle(color: colorGrey),
              ),
              const SizedBox(
                width: 20,
              ),
              const Icon(
                Icons.person_2,
                color: buttonColor,
              ),
              Text(
                Globals.currentUser!.lastname,
                style: const TextStyle(color: colorGrey),
              ),
            ],
          ),
        ),
        const Divider(
          color: colorGrey,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.email,
                color: buttonColor,
              ),
              Text(
                Globals.currentUser!.email,
                style: const TextStyle(color: colorGrey),
              ),
              const SizedBox(
                width: 20,
              ),
              const Icon(
                Icons.phone,
                color: buttonColor,
              ),
              Text(
                Globals.currentUser!.mobile,
                style: const TextStyle(color: colorGrey),
              ),
            ],
          ),
        ),
        const Divider(
          color: colorGrey,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SaveButton(title: "Edit Profile", onTap: () {}),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SaveButton(
              title: "Log Out",
              onTap: () async {
                await FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => const LoginPage(),
                    ),
                  );
                  showSnakBar("Logout Complete", context);
                });
              }),
        )
      ],
    );
  }
}
