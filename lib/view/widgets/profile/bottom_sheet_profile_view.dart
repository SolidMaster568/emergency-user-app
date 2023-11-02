import 'package:emg/screens/auth/profile/edit_profile.dart';
import 'package:emg/utils/colors.dart';
import 'package:emg/view/widgets/profile/item_widget.dart';
import 'package:emg/view/widgets/profile_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:emg/utils/globals.dart';

class BottomSheetProfileView extends StatelessWidget {
  const BottomSheetProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      "Profile data:",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: gray),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.timelapse_outlined,
                          color: offRedButton,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "60 %",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: gray),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    const ProfileImageWidget(),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${Globals.currentUser!.getFullName()}',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w700, color: colorBlack),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      Globals.currentUser!.dob.isNotEmpty
                          ? Globals.currentUser!.dob
                          : 'DD-MM-YY',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: gray),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfileScreen()));
                  },
                  child: Row(
                    children: [
                      Text(
                        "Edit",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: gray),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Icon(
                        Icons.edit_outlined,
                        color: offRedButton,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Expanded(
                  child: ProfileItemWidget(
                    subtitle: "26 years",
                    title: "Age:",
                    path: "assets/calendar.png",
                    iconColor: chryslerBlue,
                  ),
                ),
                Container(
                  height: 80,
                  width: 0.5,
                  color: Colors.black,
                ),
                const Expanded(
                  child: ProfileItemWidget(
                    subtitle: "O +",
                    title: "Blood type:",
                    path: "assets/blood.png",
                    iconColor: offRedButton,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Expanded(
                  child: ProfileItemWidget(
                    subtitle: "180 cm",
                    title: "Height:",
                    path: "assets/height.png",
                    iconColor: hunyadiYellow,
                  ),
                ),
                Container(
                  height: 80,
                  width: 0.5,
                  color: Colors.black,
                ),
                const Expanded(
                  child: ProfileItemWidget(
                    subtitle: "85 kg",
                    title: "Weight:",
                    path: "assets/weight.png",
                    iconColor: vividSkyBlue,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.email,
                      color: offRedButton,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      "johndoe@doe.com",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: gray),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      color: offRedButton,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      "0701-258-2582",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: gray),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Allergies and reactions",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: colorBlack, fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Text(
              "Blocked nose",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: gray,
                  ),
            ),
            const Divider(),
            Text(
              "Grape",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: colorBlack),
            ),
            const Divider(),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
